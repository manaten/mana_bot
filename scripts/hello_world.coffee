module.exports = (robot) ->

  robot.hear /hello world/, (bot) ->
    robot.notice bot.message.room, "こんにちは世界!"
    robot.send bot.message.room, "こんにちは世界!"
