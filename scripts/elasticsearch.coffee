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

url = (->
  host = process.env.ELASTICSEARCH_HOST or 'localhost'
  port = process.env.ELASTICSEARCH_PORT or '9200'
  index = process.env.ELASTICSEARCH_INDEX or 'irc'
  type = process.env.ELASTICSEARCH_TYPE or 'log'
  "http://#{host}:#{port}/#{index}/#{type}"
)()

module.exports = (robot) ->
  robot.hear /.*/, (msg) ->
    if msg.envelope.message.text.match /mana_bot/
      return
    if msg.envelope.user.name.match /mana_bot/
      return
    request.post
      uri: url
      json:
        user    : msg.envelope.user.name
        message : msg.envelope.message.text
        channel : msg.envelope.room
        date    : new Date().getTime()
    , (err, res, val)-> {}

  robot.hear /mana_bot.*search (.+)/, (msg) ->
    request
      uri: "#{url}/_search"
      json:
        query:
          text:
            message: msg.match[1]
        filter:
          query:
            match:
              channel: msg.envelope.room

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
