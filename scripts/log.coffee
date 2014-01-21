# Description:
#   Log messages.
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
  robot.adapter.bot.on 'raw', (message)->
    switch message.rawCommand
      when 'NOTICE', 'PRIVMSG', 'PART', 'JOIN', 'TOPIC'
        console.log JSON.stringify {
          command: message.rawCommand,
          args: message.args,
          time: new Date,
          nick: message.nick
        }
