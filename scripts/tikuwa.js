// Description:
//  任意のチャンネルに任意の長さのちくわを出現させる
//
// Dependencies:
//  lodash
//
// Commands:
//   hubot tikuwa <length> <channel> <message>

const _ = require('lodash');

module.exports = robot => {
  robot.respond(/tikuwa\s+(\d+)\s+([^\s]+)(\s+[^\s]+)?/, async msg => {
    const length = msg.match[1];
    const channel = (msg.match[2] || '').replace(/^#/, '');
    const message = msg.match[3] || ' ';

    const ch = robot.adapter.client.rtm.dataStore.getChannelOrGroupByName(channel);
    if (ch) {
      msg.send(`${channel} に長さ${length}のちくわを爆撃します！`);
      await robot.adapter.client.web.chat.postMessage(ch.id, message, {
        icon_emoji: `:tikuwa_l_1:${_.repeat(':tikuwa_l_2:', length)}:tikuwa_l_3::tikuwa_l_4:`,
        username  : 'tikuwa'
      });
    } else {
      // ユーザーかもしれない
      const user = robot.adapter.client.rtm.dataStore.getUserByName(channel);
      if (!user) {
        msg.send(`${channel}というチャンネルは存在しません`);
      }

      const im = await robot.adapter.client.web.im.open(user.id);
      msg.send(`${channel} に長さ${length}のちくわを爆撃します！`);
      await robot.adapter.client.web.chat.postMessage(im.channel.id, message, {
        icon_emoji: `:tikuwa_l_1:${_.repeat(':tikuwa_l_2:', length)}:tikuwa_l_3::tikuwa_l_4:`,
        username  : 'tikuwa'
      });
    }
  })
};
