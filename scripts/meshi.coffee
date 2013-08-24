# Description:
#   Meshi map script.
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

feedparser = require 'feedparser'
request = require 'request'

module.exports = (robot) ->
  robot.hear /mana_bot.*meshi/, (msg)->
    entries = []
    request('https://maps.google.co.jp/maps/ms?authuser=0&vps=2&brcurrent=h3,0x34674e0fd77f192f:0xf54275d47c665244&ie=UTF8&msa=0&output=kml&msid=211440039051153063058.0004e1ac26c79e7959ea9')
      .pipe(new feedparser [])
      .on('error', console.log.bind console)
      .on('data', entries.push.bind entries)
      .on('end', ->
        lastEntries = {}
        entries.forEach (entry) ->
          lastEntries[entry.link] = true
          if robot.brain.data[url]? and not robot.brain.data[url][entry.link]?
            msg.send entry.title
      )
