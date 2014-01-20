# Description:
#   Log messages.
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

module.exports = (robot) ->
  log = (nick, to, text, message)->
    console.log nick, to, text, message
  robot.adapter.bot.on 'message', log
  robot.adapter.bot.on 'notice', log

