# Description:
#   naruto huyo
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
  robot.enter (msg) ->
    robot.adapter.bot.send 'MODE', msg.envelope.room, '+o', msg.envelope.user.name
