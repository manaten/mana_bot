# Description:
#  hikari
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


module.exports = (robot) ->
  robot.hear /hikari\s+(.*)/, (msg)->
    input = msg.match[1]
    request
      uri: "http://hikari.flets-w.com/ntt-jpja/?viewtype=STANDARDJSONP&viewname=STANDARDJSONP&ARTISOLCMD_TEMPLATE=STANDARDJSONP&command=request&userinput=#{encodeURIComponent(input)}"
      method: 'GET'
    , (error, resp, body)->
      answer = body.match /"answer" : "([^"]*)"/
      if answer
        robot.adapter.notice msg.envelope, decodeURIComponent(answer[1]).replace /(<br>|\n)/g, ''
