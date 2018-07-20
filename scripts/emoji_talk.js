// Description:
//  絵文字のふりをしてBOTがしゃべります
//
// Dependencies:
// Configuration:


module.exports = (robot) => {
  robot.hear(/^:([^:]+):(.+)/, async (msg) => {
    const emoji = msg.match[1]
    await robot.adapter.client.web.chat.postMessage(msg.envelope.room, msg.match[2], {
      icon_emoji: `:${emoji}:`,
      username  : emoji.replace(/^(.)_/, '$1'),
    })
  })
};
