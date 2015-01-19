# Description:
#   Who are you?(Slack)
#
# Dependencies:
#   hubot-slack
#
# Configuration:
#   None
#
# Commands:
#   None
#

module.exports = (robot) ->
  getProfile = (userName) ->
    robot.adapter.client.getUserByName(userName).profile

  sendProfile = (msg, userName) ->
    profile = getProfile userName
    return unless profile?

    msg.send profile.real_name
    msg.send "email: #{profile.email}"
    msg.send "title: #{profile.title}"

  robot.hear /^whoami/, (msg)-> sendProfile msg, msg.envelope.user.name
  robot.hear /^whois (.+)/, (msg)-> sendProfile msg, msg.match[1]
