// Description:
//   Simple url decoder
//
// Dependencies:
//   None
//
// Configuration:
//   None
//
// Commands:
//   <URLエンコードされた文字列> - URLデコードを行う

module.exports = robot => {
  robot.hear(/(%[0-9A-Fa-f]{2})+/, msg => {
    msg.send(decodeURIComponent(msg.message.text));
  });

  robot.hear(/(\\[xu][0-9A-Fa-f]+)+/i, msg => {
    msg.send(msg.message.text.replace(/\\[xu]([0-9A-Fa-f]+)/ig, (_, $1) => String.fromCharCode(parseInt($1, 16))));
  });
};
