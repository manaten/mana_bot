# Description:
#   Who are you?
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
  robot.hear /^whoami/, (msg)->
    robot.adapter.bot.whois msg.envelope.user.name, (res)->
      realname = res.realname.replace /@.*$/, ''
      robot.adapter.notice msg.envelope, realname

  robot.hear /^whois (.+)/, (msg)->
    robot.adapter.bot.whois msg.match[1], (res)->
      realname = res.realname.replace /@.*$/, ''
      robot.adapter.notice msg.envelope, realname
