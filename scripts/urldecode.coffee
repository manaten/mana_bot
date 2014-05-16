# Description:
#   Simple url decoder
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
  robot.hear /(%[0-9A-F]{2}){2,}/, (msg) ->
    robot.adapter.notice msg.envelope, decodeURIComponent msg.message.text
