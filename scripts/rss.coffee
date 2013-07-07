# Description:
#   Send from rss example.
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
  robot.enter ->
    new cron
      cronTime: '0 * * * * *',
      start: true,
      timeZone: "Asia/Tokyo",

      onTick: ->
        request("http://b.hatena.ne.jp/entrylist?sort=hot&threshold=3&mode=rss")
          .pipe(new feedparser [])
          .on('error', (error) ->
            console.log error
          )
          .on('data', (entry) ->
            console.log entry.title
            #robot.send {room:"#mana_bot"}, "#{entry.title} #{entry.link} #{entry.description} #{entry.date}"
          )


