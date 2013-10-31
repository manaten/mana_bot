# Description:
#   Who am I?
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
 robot.hear /whoami/, (bot)->
    robot.adapter.bot.whois bot.envelope.user.name, (res)->
      realname = res.realname.replace /@.*$/, ''
      robot.adapter.notice bot.envelope, realname
