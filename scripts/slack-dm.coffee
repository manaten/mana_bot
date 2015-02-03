# Description:
#   send slack dm.
#
# Dependencies:
#   hubot-slack
#
# Configuration:
#   None
#
# Commands:
#   dm username message

module.exports = (robot) ->
  sendDM = (slackUserName , message) ->
    userId = robot.adapter.client.getUserByName(slackUserName)?.id
    return unless userId?

    if robot.adapter.client.getDMByID(userId)?
      robot.send {room: slackUserName}, message
    else
      robot.adapter.client.openDM userId
      # openをハンドルする手段がなさそうなので、仕方なくsetTimeout
      setTimeout =>
        robot.send {room: slackUserName}, message
      , 1000

  robot.respond /dm ([^\s]+) (.+)/, (msg) ->
    userName = msg.match[1]
    message = msg.match[2]
    sendDM userName, message
