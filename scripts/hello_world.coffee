# Description:
#   Hello, Hubot!
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
  console.log 'loading hello.coffee ' + Date.now()

  robot.hear /hello world/, (msg) ->
    msg.send "こんにちは世界!"

  robot.hear /(かっ|カッ)ちゃん/, (msg) ->
    msg.send "ﾊﾊ､"
    setTimeout ->
      msg.send "ﾊﾊﾊ､"
    , 1000
    setTimeout ->
      msg.send "ﾊﾊﾊ…"
    , 2000

  robot.hear /ごっちゃん/, (msg) ->
    msg.send "ﾄﾞﾝ､"
    setTimeout ->
      msg.send "ﾄﾞｺ､"
    , 1000
    setTimeout ->
      msg.send "ﾄﾞﾝ…"
    , 2000

  #robot.hear /ごっつ/, (bot) ->
    #msg.send "ﾄﾞﾝﾄﾞｺﾄﾞﾝﾄﾞｺﾄﾞﾝﾄﾞｺ…"

  robot.hear /(かっ|カッ)(つ|ツ)/, (msg) ->
    msg.send "ﾊｯﾊﾊﾊｯﾊﾊﾊｯﾊﾊ…"

  robot.hear /^(gm|ｇｍ)/, (msg) ->
    msg.send "gm"
