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

formatDate = (d, formatStr)->
  a = {
    Y: d.getFullYear,
    m: ()-> ('0'+(d.getMonth()+1)).slice(-2),
    d: ()-> ('0'+d.getDate()).slice(-2),
    H: ()-> ('0'+d.getHours()).slice(-2),
    i: ()-> ('0'+d.getMinutes()).slice(-2),
    s: ()-> ('0'+d.getSeconds()).slice(-2)
  }
  formatStr.replace /[YmdHis]/g, (l)-> a[l].apply(d)


module.exports = (robot) ->
  robot.enter (msg) ->
    if dengons = robot.brain.data.dengon[msg.envelope.room][msg.envelope.user.name]
      dengons.forEach (dengon)->
        date = formatDate('m/d H:i', new Date(dengon.time))
        robot.send msg.envelope, "#{date} <#{dengon.sender}> #{dengon.message}"
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
