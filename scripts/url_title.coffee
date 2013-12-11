# Description:
#   Say title when hear URL.
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
#

request = require 'request'
cheerio = require 'cheerio'

module.exports = (robot) ->
  robot.hear /(h?ttps?:\/\/[-a-zA-Z0-9@:%_\+.~#?&\/=]+)/i, (msg)->
    request { uri: msg.match[1] }, (error, response, body)->
      return if error
      $ = cheerio.load body.replace(/<!\[CDATA\[([^\]]+)]\]>/ig, "$1")
      title = $("title")
      robot.adapter.notice msg.envelope, "#{title.text()}" if title
