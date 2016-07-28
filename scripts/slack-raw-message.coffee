#
# Description:
#   Listen slack raw messages.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#

module.exports = (robot) ->
  robot.adapter.client.on 'raw_message', (message) ->
    robot.emit "Slack:#{message.type}", message
