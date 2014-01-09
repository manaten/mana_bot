# Description:
# Send a Dengon(伝言) to somebody not here.
#
# Dependencies:
# None
#
# Configuration:
# None
#
# Commands:
# None
#

module.exports = (robot) ->
  robot.enter (msg) ->
    if dengons = robot.brain.data.dengon[msg.envelope.room][msg.envelope.user.name]
      dengons.forEach (dengon)->
        robot.adapter.notice msg.envelope, "#{new Date(dengon.time}) <#{dengon.sender}> #{dengon.message}"
      delete robot.brain.data.dengon[msg.envelope.room][msg.envelope.user.name]
      robot.brain.save()

  robot.hear /^伝言 ([^\s]*) (.*)/, (msg)->
    target = msg.match[1]
    message = msg.match[2]

    robot.brain.data.dengon = {} if !robot.brain.data.dengon
    robot.brain.data.dengon[msg.envelope.room] = {} if !robot.brain.data.dengon[msg.envelope.room]
    robot.brain.data.dengon[msg.envelope.room][target] = [] if !robot.brain.data.dengon[msg.envelope.room][target]
    robot.brain.data.dengon[msg.envelope.room][target].push {
      message: message,
      sender:  msg.envelope.user.name,
      time:    new Date().getTime()
    }
    robot.brain.save()
