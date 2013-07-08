# Description:
#   Send from rss.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#

cron = require('cron').CronJob
feedparser = require 'feedparser'
request = require 'request'

module.exports = (robot) ->
  watchFeed = (cronTime, url, callback) ->
    new cron
      cronTime: cronTime
      start: true
      timeZone: "Asia/Tokyo"
      onTick: ->
        entries = []
        request(url)
          .pipe(new feedparser [])
          .on('error', console.log.bind console)
          .on('data', entries.push.bind entries)
          .on('end', ->
            lastEntries = {}
            entries.forEach (entry) ->
              lastEntries[entry.link] = true
              if robot.brain.data[url]? and not robot.brain.data[url][entry.link]?
                callback entry

            robot.brain.data[url] = lastEntries
            robot.brain.save()
          )

  robot.enter ->
    watchFeed '0 * * * * *', "http://b.hatena.ne.jp/entrylist?sort=hot&threshold=3&mode=rss", (entry) ->
      console.log entry.title
      robot.send { room: "#mana_bot" }, "#{entry.title} #{entry.link}"


