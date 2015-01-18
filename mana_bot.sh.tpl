#!/bin/sh

PATH=/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export PORT="9090"
export HUBOT_HTTPD="true"
export HUBOT_SLACK_TOKEN=""

case $1 in
    "start" )
        ./node_modules/.bin/forever $1 \
            --pidfile /var/run/mana_bot.pid \
            -l /var/log/mana_bot.log -a \
            --uid "mana_bot" \
            -c ./node_modules/.bin/coffee node_modules/.bin/hubot -a slack -n mana_bot
    ;;
    "stop" | "restart" )
        ./node_modules/.bin/forever $1 "mana_bot"
    ;;
    * ) echo "usage: run.sh start|stop|restart" ;;
esac
