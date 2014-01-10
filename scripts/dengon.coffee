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
    for targetUser, dengons of robot.brain.data.dengon[msg.envelope.room]
      if new RegExp("#{targetUser}?[\d_]*").test msg.envelope.user.name
        msg.send "#{formatDate new Date(dengon.time), 'm/d H:i'} <#{dengon.sender}> #{dengon.message} #{msg.envelope.user.name}" for dengon in dengons
        delete robot.brain.data.dengon[msg.envelope.room][targetUser]
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
    robot.adapter.notice msg.envelope, "伝言を受け付けました #{msg.envelope.user.name}"
