# Description:
# Send message from http.
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
# URLS:
# /send
# /notice
#

module.exports = (robot) ->

  robot.router.get "/send", (req, res) ->
    msg = req.query.message
    ch = "#" + req.query.channel.replace /^#/, ''

    robot.send { room: ch }, msg
    res.end JSON.stringify {method:"send",ch:ch,msg:msg}

  robot.router.get "/notice", (req, res) ->
    msg = req.query.message
    ch = "#" + req.query.channel.replace /^#/, ''

    robot.adapter.notice { room: ch }, msg
    res.end JSON.stringify {method:"notice",ch:ch,msg:msg}

