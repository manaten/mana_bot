cron = require('cron').CronJob

module.exports = (robot) ->
  robot.enter ->
    new cron
      cronTime: '* * * * * *',
      start: true,
      timeZone: "Asia/Tokyo",

      onTick: ->
        console.log "test"
        #robot.send { room:"#all" }, "11時ですよー"

