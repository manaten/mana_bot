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
  charset = body.toString('ascii').match /<meta[^>]*[\s;]+charset\s*=\s*["']?([\w\-_]+)["']?/i
  return new iconv.Iconv(charset[1].trim(), 'UTF-8//TRANSLIT//IGNORE').convert(body) if charset
  body

module.exports = (robot) ->
  robot.hear /(h?ttps?:\/\/[-a-zA-Z0-9@:%_\+.~#?&\/=]+)/i, (msg)->
    uri = msg.match[1]
    # 社内URLだと事務的に使われていちいち喋られるとうざいので、喋らない(そもそもログイン必要だったりするしね)
    return if uri.match /(dwango\.co|nicovideo)\.jp/
    request { uri: uri, encoding: null }, (error, response, body)->
      return if error

      $ = cheerio.load convertEncode(body).toString().replace(/<!\[CDATA\[([^\]]+)]\]>/ig, "$1")
      title = $("title")
      robot.adapter.notice msg.envelope, "#{title.text()}" if title
