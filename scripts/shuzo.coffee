# Description:
#   Motto astuku nareyo!
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

msgs = [
  '人の弱点を見つける天才よりも、人を褒める天才がいい',
  '勝ち負けなんか、ちっぽけなこと。大事なことは本気だったかどうかだ！',
  '一所懸命生きていれば、不思議なことに疲れない',
  '眉間に皺を寄せていたところで怪我が早く治るわけでもない。 むしろ、明るく危機を受け止める姿勢にこそ早く治るきっかけがある',
  'やがて僕のレベルも知らず知らずに上がっていった。なぜなら、僕が戦う相手は、いつも自分より強かったからである',
  'この一球は絶対無二の一球なり',
  '100回叩くと壊れる壁があったとする。でもみんな何回叩けば壊れるかわからないから、90回まで来ていても途中であきらめてしまう。',
  '布団たたきは、やめられない。ついつい叩きすぎちゃう',
  '人もテニスも、ラブから始まる',
  '僕自身「世界No.1の選手と話しをしろ」「練習をしろ」と言われた。「そうすることで、世界No.1の選手が普通の人に見えてくる」と。',
  'ミスをすることは悪いことじゃない。それは上達するためには必ず必要なもの。ただし、同じミスはしないこと',
  '弱気になったとき、まず一ヵ月後の自分を想像してみる。それが自分の好きな姿だとしたら、そのために何をするべきかを考える。そうすれば、少なくともその日までは目的意識を保ち続けることができる',
  '褒め言葉よりも苦言に感謝',
  '僕こそがテニスの王子様',
  '崖っぷちありがとう！！最高だ！！',
  'レストランなどでの注文をメニューを見て５秒以内で決める',
  '人は完璧を求める。しかし、完璧だと思った時から全てがやり直しになる',
  'テニスという言葉を、軽々しく口にするな！',
  'これは終わりではなく、新たしい修造の始まり',
  '編集が怖くて、テレビになんか出られるか！',
  '涙よりも、血よりも、汗を流していたい',
  '暑くなければ夏じゃない。熱くなければ人生じゃない！',
  '諦めるなよ！！諦めるなお前！！',
  '人は完璧を求める。しかし、完璧だと思った時から全てがやり直しになる',
  'チャンスをピンチにするな！',
  '偶然やラッキーなどない。つかんだのはおまえだ！',
  '自分を創るのは自分だ！',
  '予想外の人生になっても、そのとき、幸せだったらいいんじゃないかな',
  '褒め言葉よりも苦言に感謝',
  'ベストを尽くすだけでは勝てない。僕は勝ちにいく',
  '時間が解決してくれると言うけれど、そうは思わない。でも、行動した時間なら解決してくれるはずだ。',
  '何かを認識してやってみることが「体験」、その体験を二度三度重ねていくことで「経験」になっていく',
  'プレッシャーを感じられることは幸せなことだ',
  'じゃんけんの必勝法は、強く握り締めたグーを出すこと',
  'しゃもじがあると、素振りをしちゃう',
  '悩みん坊、万歳！'
]


module.exports = (robot) ->
  suzo = (bot) ->
    msg = msgs[Math.floor(Math.random() * msgs.length)]
    robot.adapter.notice bot.envelope, "#{msg} #{bot.envelope.user.name}"

  robot.hear /(だめだ|いやだ|できない|やりたくない|あきらめ|諦め|オワタ|やめよう|死のう|死にたい)/, (bot) ->
    suzo \x0304"#{bot}\x03"
