#!/bin/sh

export PORT="9090"
export HUBOT_HTTPD="true"
export HUBOT_IRC_NICK="mana_bot"
export HUBOT_IRC_ROOMS="#mana_bot"
export HUBOT_IRC_SERVER="manaten.net"

./node_modules/hubot/bin/hubot -a irc
