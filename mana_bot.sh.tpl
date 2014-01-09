#!/bin/sh

PATH=/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export PORT="9090"
export HUBOT_HTTPD="true"
export HUBOT_IRC_NICK="mana_bot"
export HUBOT_IRC_ROOMS="#mana_bot"
export HUBOT_IRC_SERVER="manaten.net"

case $1 in
    "start" | "stop" | "restart" )
       `pwd`/node_modules/forever/bin/forever $1 \
           -p /var/run/forever \
           --pidfile /var/run/mana_bot.pid \
           -l /var/log/mana_bot.log -a \
           -c `pwd`/node_modules/coffee-script/bin/coffee `pwd`/node_modules/hubot/bin/hubot --adapter irc
    ;;
    * ) echo "usage: manabot start|stop|retart" ;;
esac
