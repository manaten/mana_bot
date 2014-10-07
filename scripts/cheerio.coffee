# Description:
# Run cheerio script.
#
# Dependencies:
# None
#
# Configuration:
# None
#
# Commands:
# None

request = require 'request'
cheerio = require 'cheerio'

module.exports = (robot) ->
  robot.hear /^cheerio ([^\s]*) (.*)/, (msg)->
    url = msg.match[1]
    script = msg.match[2]

    request { uri: url, timeout: 30 * 1000 }, (error, response, body)->
      # cheerioでCDATAをパースできないらしいので、除去してからパース http://stackoverflow.com/questions/15472213/nodejs-using-cheerio-parsing-xml-returns-empty-cdata
      $ = cheerio.load body.replace(/<!\[CDATA\[([^\]]+)]\]>/ig, "$1")

      try
        robot.adapter.notice msg.envelope, "#{eval script}"
      catch e
        robot.adapter.notice msg.envelope, "#{e}"

