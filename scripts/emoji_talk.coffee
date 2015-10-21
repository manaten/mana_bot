# Description:
#  絵文字のふりをしてBOTがしゃべります
#
# Dependencies:
#
#
# Configuration:
#


module.exports = (robot) ->
  robot.hear /^:([^:]+):(.+)/, (msg) ->
    chid = robot.adapter.client.getChannelGroupOrDMByName(msg.envelope.room)?.id
    return unless chid

    emoji = msg.match[1]
    robot.adapter.client._apiCall 'chat.postMessage',
      channel   : chid
      text      : msg.match[2]
      icon_emoji: ":#{emoji}:"
      username  : emoji.replace /^(.)_/, '$1'
    , (res) ->
      null
