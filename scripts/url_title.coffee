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

request = require 'request'
cheerio = require 'cheerio'
iconv   = require 'iconv'

convertEncode = (body) ->
  charset = body.toString('ascii').match /<meta[^>]*charset\s*=\s*["']?([-\w]+)["']?/i
  return new iconv.Iconv(charset[1], 'UTF-8//TRANSLIT//IGNORE').convert(body) if charset
  body

module.exports = (robot) ->
  robot.hear /(h?ttps?:\/\/[-\w@:%\+.~#?&\/=]+)/i, (msg)->
    uri = msg.match[1]
    request { uri: uri, encoding: null }, (error, response, body)->
      return if error

      $ = cheerio.load convertEncode(body).toString().replace(/<!\[CDATA\[([^\]]+)]\]>/ig, "$1")
      title = $("title")
      if title
        titleText = title.text().replace(/^[\s\n]+/, '').replace(/[\s\n]+$/, '')
        msg.send "#{titleText}"
