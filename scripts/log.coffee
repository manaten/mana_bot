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
  robot.adapter.bot.on 'raw', (message)->
    console.log JSON.stringify message
