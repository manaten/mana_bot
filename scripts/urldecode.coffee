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
  robot.hear /urldecode\s+(.*)/, (msg) ->
    input = msg.match[1]
    robot.adapter.notice msg.envelope, decodeURIComponent(input)
