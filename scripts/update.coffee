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
  robot.hear /mana_bot.*update/, (msg) ->
    try
      msg.send "updating..."
      child_process.exec 'git pull', (error, stdout, stderr) ->
        if error
          msg.send "git pull failed: " + stderr
        else
          output = stdout + ''
          if not /Already up\-to\-date/.test output
            msg.send "mana_botが更新されました: " + output
            msg.send "npmの更新をします"
            child_process.exec 'npm install', (error, stdout, stderr) ->
              msg.send "再起動します"
              console.log "mana_bot exit..."
              process.exit()
          else
            msg.send "mana_botは最新です"
    catch e
      msg.send "git pull failed:" + e

  robot.hear /mana_bot.*restart/, (msg) ->
    msg.send "再起動します"
    console.log "mana_bot exit..."
    process.exit()

