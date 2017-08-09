// Description:
//   Who are you?(Slack)
//
// Dependencies:
//   hubot-slack
//
// Configuration:
//   None
//
// Commands:
//   whois <username> - usernameの本名を表示
//   whoami - 自身の本名を表示
//

module.exports = robot => {
  const getUser = userName => robot.adapter.client.rtm.dataStore.getUserByName(userName);

  const sendProfile = (msg, userName) => {
    const user = getUser(userName);
    if (!user || !user.profile) {
      return;
    }

    robot.logger.info(user.profile);
    const flags = [
        user.is_admin && 'admin',
        user.is_owner && 'owner',
        user.is_primary_owner && 'primary_owner',
        user.is_restricted && 'restricted',
        user.is_ultra_restricted && 'ultra_restricted',
        user.is_bot && 'bot',
      ].filter(e => e).join(', ') || '(none)';

    const image = user.profile.image_original || user.profile.image_512 || user.profile.image_192 || user.profile.image_72 || user.profile.image_48 || user.profile.image_32 || user.profile.image_24;
    msg.send(`\
>>>
${user.profile.real_name} (ID:${user.id})
email: ${user.profile.email}
title: ${user.profile.title}
flags: ${flags}
image: ${image}\
`
    );
  };

  robot.hear(/^whoami/, msg => sendProfile(msg, msg.envelope.user.name));
  robot.hear(/^whois\s+(.+)/, msg => msg.match[1].split(/\s+/).forEach(name => sendProfile(msg, name)));

  robot.respond(/whoami/, msg => sendProfile(msg, msg.envelope.user.name));
  robot.respond(/whois\s+(.+)/, msg => msg.match[1].split(/\s+/).forEach(name => sendProfile(msg, name)));
};
