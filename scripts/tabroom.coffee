# Description:
#   tabroom script.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None

TABROOM_URL = 'http://tabroom.jp/all/?freeWord='

request = require 'request'
cheerio = require 'cheerio'

module.exports = (robot) ->
  robot.hear /mana_bot.*room (.+)/, (msg)->
    request { uri: "#{TABROOM_URL}#{msg.match[1]}" }, (error, response, body)->
      $ = cheerio.load(body)

      items = []
      $("script").each ->
        script = $(this).text()
        if /^bct.items/m.test script
          result = (script.replace(/[\n\r]/igm, '').match /bct.items = ({.+});/)[1]
          eval("var __items = #{result}")
          for key, item of __items
            if key isnt ''
              items.push { key: key, name: item.itemName }
              console.log { key: key, name: item.itemName }

      if items.length
        item = items[Math.floor( Math.random() * items.length )]
        robot.adapter.notice msg.envelope, "#{item.name} http://tabroom.jp/desk/office-desk/#{item.key}"
