# Description:
#   update self when recieve update message.
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
child_process = require 'child_process'

module.exports = (robot) ->
  robot.hear /mana_bot.*update/, (bot) ->
    try
      robot.adapter.notice bot.envelope, "updating..."
      child_process.exec 'git pull', (error, stdout, stderr) ->
        if error
          robot.adapter.notice bot.envelope, "git pull failed: " + stderr
        else
          output = stdout + ''
          if not /Already up\-to\-date/.test output
            robot.adapter.notice bot.envelope, "mana_botが更新されました: " + output
            robot.adapter.notice bot.envelope, "npmの更新をします"
            child_process.exec 'npm install', (error, stdout, stderr) ->
              robot.adapter.notice bot.envelope, "再起動します"
              console.log "mana_bot exit..."
              process.exit()
          else
            robot.adapter.notice bot.envelope, "mana_botは最新です"
    catch e
      robot.adapter.notice bot.envelope, "git pull failed:" + e

  robot.hear /mana_bot.*restart/, (bot) ->
    robot.adapter.notice bot.envelope, "再起動します"
    console.log "mana_bot exit..."
    process.exit()

