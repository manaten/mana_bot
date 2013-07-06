module.exports = (robot) ->
  robot.notice = (target, str) -> @adapter.bot.notice(target, str)
