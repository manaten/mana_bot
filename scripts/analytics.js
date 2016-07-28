/**
 * Description:
 *
 *
 * Dependencies:
 *
 * Configuration:
 *   None
 *
 * Commands:
*/

import _ from 'lodash';
import google from 'googleapis';
import {CronJob as cron} from 'cron';
import moment from 'moment';

const OAuth2 = google.auth.OAuth2;

const [GA_ID, CLIENT_ID, CLIENT_SECRET, ACCESS_TOKEN, REFRESH_TOKEN] = process.env.GOOGLE_API_TOKENS.split(',');

const oauth2Client = new OAuth2(CLIENT_ID, CLIENT_SECRET);

oauth2Client.setCredentials({
  access_token : ACCESS_TOKEN,
  refresh_token: REFRESH_TOKEN,
  expiry_date  : 1
});
const analytics = google.analytics({version: 'v3', auth: oauth2Client});

const callGaGet = params =>
  new Promise((resolve, reject) =>
    analytics.data.ga.get(params, (err, res) => err ? reject(err) : resolve(res))
  ).then(res => res.rows.map(row => _.zipObject(_.map(res.columnHeaders, 'name'), row)));

const getUUPV = (start, end) => callGaGet({
  'ids'       : GA_ID,
  'start-date': start,
  'end-date'  : end,
  'metrics'   : 'ga:users,ga:pageviews'
});

const getUUPVByPage = (start, end) => callGaGet({
  'ids'        : GA_ID,
  'start-date' : start,
  'end-date'   : end,
  'metrics'    : 'ga:users,ga:pageviews',
  'dimensions' : 'ga:pagePath,ga:pageTitle',
  'sort'       : '-ga:pageviews',
  'max-results': '20'
});

const formatDiff = (currentVal, prevVal) => (parseInt(currentVal) > parseInt(prevVal)? '+' : '') + `${currentVal - prevVal}`
const formatTable = table => {
  const columnLengths = _.range(table[0].length).map(index => _.max(_.map(table, row => `${row[index]}`.length)));
  return table.map(row => row.map((elem, index) => _.padEnd(elem, columnLengths[index])).join(' ')).join('\n');
}

const getUUPVStats = async (prevStart, prevEnd, currStart, currEnd) => {
  const [prev, cur] = await Promise.all([
    getUUPV(prevStart, prevEnd),
    getUUPV(currStart, currEnd),
  ]);
  const result = [['PV', 'UU'], [
    `${cur[0]['ga:pageviews']} (${formatDiff(cur[0]['ga:pageviews'], prev[0]['ga:pageviews'])})`,
    `${cur[0]['ga:users']} (${formatDiff(cur[0]['ga:users'], prev[0]['ga:users'])})`
  ]];
  return formatTable(result);
};

const getPVByPageStats = async (prevStart, prevEnd, currStart, currEnd) => {
  const [prev, cur] = await Promise.all([
    getUUPVByPage(prevStart, prevEnd),
    getUUPVByPage(currStart, currEnd),
  ]);

  const result = [['page', 'PV', 'UU', 'title']].concat(cur.map(row => {
    const prevRow = _.find(prev, elem => elem['ga:pagePath'] === row['ga:pagePath']);
    return [
      row['ga:pagePath'],
      `${row['ga:pageviews']} (${prevRow ? formatDiff(row['ga:pageviews'], prevRow['ga:pageviews']) : '*'})`,
      `${row['ga:users']} (${prevRow ? formatDiff(row['ga:users'], prevRow['ga:users']) : '*'})`,
      _.truncate(row['ga:pageTitle'], 30)
    ];
  }));
  return formatTable(result);
};


module.exports = robot => {
  const report = async (room, interval = 'day') => {
    const [prevStart, prevEnd, currStart, currEnd] = {
      month: [
        moment().add(-2, 'months').format('YYYY-MM-01'),
        moment().endOf('month').add(-2, 'months').format('YYYY-MM-DD'),
        moment().add(-1, 'months').format('YYYY-MM-01'),
        moment().endOf('month').add(-1, 'months').format('YYYY-MM-DD')
      ],
      day: [
        moment().add(-2, 'days').format('YYYY-MM-DD'),
        moment().add(-2, 'days').format('YYYY-MM-DD'),
        moment().add(-1, 'days').format('YYYY-MM-DD'),
        moment().add(-1, 'days').format('YYYY-MM-DD')
      ]
    }[interval];

    robot.send({room}, `集計期間: ${currStart} ~ ${currEnd} 比較期間: ${prevStart} ~ ${prevEnd}`);

    try {
      const pvuustats = await getUUPVStats(prevStart, prevEnd, currStart, currEnd);
      robot.send({room}, '```\n' + pvuustats + '\n```');

      const pagestats = await getPVByPageStats(prevStart, prevEnd, currStart, currEnd);
      robot.send({room}, '```\n' + pagestats + '\n```');
    } catch(e) {
      robot.logger.error(e);
    }
  };

  // 毎日11時に日次レポート
  new cron({
    cronTime: '00 00 11 * * *',
    start   : true,
    timeZone: "Asia/Tokyo",
    onTick  : () => report('G03D336T0')
  });

  // 毎月1日の11時に月次レポート
  new cron({
    cronTime: '00 00 11 1 * *',
    start   : true,
    timeZone: "Asia/Tokyo",
    onTick  : () => report('G03D336T0', 'month')
  });

  robot.respond(/analytics:month/, res => {
    report(res.envelope.room, 'month');
  });

  robot.respond(/analytics\s*$/, res => {
    report(res.envelope.room);
  });
};
