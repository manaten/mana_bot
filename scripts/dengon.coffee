# Description:
#   Send a Dengon(伝言) to somebody not here.
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
  robot.leave (msg) ->
    console.log msg.envelope.user.name
