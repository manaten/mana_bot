#!/bin/sh

export PORT="9090"
export HUBOT_HTTPD="true"
export HUBOT_IRC_NICK="mana_bot"
export HUBOT_IRC_ROOMS="#mana_bot"
export HUBOT_IRC_SERVER="manaten.net"

case $1 in
    "start" | "stop" | "restart" )
       /home/mana/mana_bot/node_modules/forever/bin/forever $1 \
           -p /var/run/forever \
           --pidfile /var/run/mana_bot.pid \
           -l /var/log/mana_bot.log -a \
           -c coffee /home/mana/mana_bot/node_modules/hubot/bin/hubot --adapter irc
    ;;
    * ) echo "usage: manabot start|stop|retart" ;;
esac
