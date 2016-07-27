#
# Description:
#   Notify slack stared.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#

# hubot-slack4系で動かない
module.exports = (robot) ->
  robot.on 'Slack:star_added', (message) ->
    stareeUser = (robot.adapter.client.getUserByID message.user).name.replace /(.)$/, '.$1'
    staredUser = (robot.adapter.client.getUserByID message.item.message.user).name
    permalink = message.item.message.permalink
    robot.send { room: 'star' }, "@#{staredUser} #{stareeUser} が #{permalink} を :star:"
