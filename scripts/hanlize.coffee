# Description:
#   hanlizer.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None

module.exports = (robot) ->
  robot.hear /mana_bot.*hanlize (.+)/, (msg)->
    robot.adapter.notice msg.envelope, msg.match[1].replace(/([ア-ン])([ア-ン])(ー)/g, "$1$3$2")
