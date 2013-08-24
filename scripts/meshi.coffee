# Description:
#   Meshi map script.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None

GOOGLE_MAP_URL = 'https://maps.google.com/?q='
MESHIMAP_URL = 'https://maps.google.co.jp/maps/ms?authuser=0&vps=2&brcurrent=h3,0x34674e0fd77f192f:0xf54275d47c665244&ie=UTF8&msa=0&output=kml&msid=211440039051153063058.0004e1ac26c79e7959ea9'

request = require 'request'
cheerio = require 'cheerio'

module.exports = (robot) ->
  robot.hear /mana_bot.*meshi/, (msg)->
    request { uri: MESHIMAP_URL }, (error, response, body)->
      $ = cheerio.load(body)

      places = []
      $("placemark").each ->
        places.push {
          name:        $(this).find('name').text(),
          coordinates: $(this).find('coordinates').text()
        }

      place = places[Math.floor(Math.random() * places.length)]
      coodinates = place.coordinates.split(',')
      msg.send "#{place.name} #{GOOGLE_MAP_URL}#{coodinates[1]},#{coodinates[0]}"
