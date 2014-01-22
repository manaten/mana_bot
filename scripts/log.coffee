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
fs = require 'fs'
LOG_ROOT = '/var/log/mana_bot'

module.exports = (robot) ->
  robot.adapter.bot.on 'raw', (message)->
    switch message.rawCommand
      when 'NOTICE', 'PRIVMSG', 'PART', 'JOIN', 'TOPIC'
        channel = message.args[0].replace /^#/, ''
        time = new Date
        year = time.getFullYear()
        month = time.getMonth()+1
        date = time.getDate()
        
        logContent = JSON.stringify {
          command: message.rawCommand,
          args: message.args,
          time: time,
          nick: message.nick
        }
        dir = "#{LOG_ROOT}/#{channel}/#{year}/#{month}"
        fs.exists(dir, (exists)->
          if exists
            fs.appendFile "#{dir}/#{date}", logContent, (err)->
              console.log err
          else
            fs.mkdir dir, ->
              fs.appendFile "#{dir}/#{date}", logContent, (err)->
                console.log err
        )
        
