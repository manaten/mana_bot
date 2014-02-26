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
  robot.hear /hello world/, (bot) ->
    robot.send bot.envelope, "こんにちは世界!"
    robot.adapter.notice bot.envelope, "こんにちは世界!"

  robot.hear /(かっ|カッ)ちゃん/, (bot) ->
    robot.adapter.notice bot.envelope, "ﾊﾊ､"
    setTimeout ->
      robot.adapter.notice bot.envelope, "ﾊﾊﾊ､"
    , 1000
    setTimeout ->
      robot.adapter.notice bot.envelope, "ﾊﾊﾊ…"
    , 2000

  robot.hear /ごっつ/, (bot) ->
    robot.adapter.notice bot.envelope, "ﾄﾞﾝﾄﾞｺﾄﾞﾝﾄﾞｺﾄﾞﾝﾄﾞｺ…"

  robot.hear /^(gm|ｇｍ)/, (bot) ->
    robot.adapter.notice bot.envelope, "gm"
