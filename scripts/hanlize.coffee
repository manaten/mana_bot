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
    robot.adapter.notice msg.envelope, msg.match[1].replace(/[ア-ン][ア-ン]ー/g, (str)->
      str.charAt(0) + str.charAt(2) + str.charAt(1)
    )
