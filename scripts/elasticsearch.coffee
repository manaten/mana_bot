# Description:
#   elasticsearch logging and search
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
request = require 'request'

module.exports = (robot) ->
  robot.hear /.*/, (msg) ->
    if msg.envelope.message.text.match /mana_bot/
      return
    if msg.envelope.user.name.match /mana_bot/
      return
    request.post
      uri: 'http://localhost:9200/irc/log'
      json:
        user    : msg.envelope.user.name
        message : msg.envelope.message.text
        channel : msg.envelope.room
        date    : new Date().getTime()
    , (err, res, val)-> {}

  robot.hear /mana_bot.*search (.+)/, (msg) ->
    request
      uri: 'http://localhost:9200/irc/log/_search'
      json:
        query:
          text:
            message: msg.match[1]
        sort : [
          date :
            order : "desc"
        ]
        from : 0
        size : 5

    , (err, res, val)->
      val.hits.hits.forEach (d)->
        date = new Date(d._source.date)
        robot.adapter.notice msg.envelope, "#{date} #{d._source.user}: #{d._source.message}"
