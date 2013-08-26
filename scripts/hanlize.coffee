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
    robot.adapter.notice msg.envelope, msg.match[1].replace(/[ア-ン]ー/g, (str)->
      str.charAt(1) + str.charAt(0)
    )
