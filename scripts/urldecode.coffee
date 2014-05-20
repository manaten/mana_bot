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
  robot.hear /(%[0-9A-Fa-f]{2})+/, (msg) ->
    robot.adapter.notice msg.envelope, decodeURIComponent msg.message.text

  robot.hear /(\\[xu][0-9A-Fa-f]+)+/, (msg) ->
    robot.adapter.notice msg.envelope, msg.message.text.replace(/\\[xu]([0-9A-Fa-f]+)/g, (_, $1)-> String.fromCharCode parseInt $1, 16)
