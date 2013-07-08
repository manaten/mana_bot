# Description:
#   Send message from http.
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
# URLS:
#   /send
#

module.exports = (robot) ->

  robot.router.get "/send", (req, res) ->
    msg = req.query.msg
    ch = req.query.ch

    robot.send { room: ch }, msg
    res.end JSON.stringify {ch:ch,msg:msg}

