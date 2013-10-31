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
    console.log msg
    robot.bot.send 'mode' "#{msg.envelope.room}" '+o' "#{msg.envelope.user.name}"
