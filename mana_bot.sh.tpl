#!/bin/sh

PATH=/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export PORT="9090"
export HUBOT_HTTPD="true"
export HUBOT_SLACK_TOKEN=""

babel-hubot -a slack -n mana_bot
