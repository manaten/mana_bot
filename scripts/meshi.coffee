# Description:
# Meshi map script.
#
# Dependencies:
# None
#
# Configuration:
# None
#
# Commands:
# None

GOOGLE_MAP_URL = 'https://maps.google.com/?q='
MESHIMAP_URL = 'https://maps.google.co.jp/maps/ms?dg=feature&ie=UTF8&authuser=0&msa=0&output=kml&msid=208716591539458475045.0004e3ba3f7aaddff9ea7'

request = require 'request'
cheerio = require 'cheerio'

module.exports = (robot) ->
  robot.hear /mana_bot.*meshi/, (msg)->
    request { uri: MESHIMAP_URL }, (error, response, body)->
      $ = cheerio.load body.replace(/<!\[CDATA\[([^\]]+)]\]>/ig, "$1")
      places = $("placemark").map ->
        {
          name: $(this).find('name').text(),
          coordinates: $(this).find('coordinates').text(),
          description: $(this).find('description').text()
        }

      place = places[Math.floor(Math.random() * places.length)]
      coodinates = place.coordinates.split(',')
      robot.adapter.notice msg.envelope, "#{place.name} #{GOOGLE_MAP_URL}#{coodinates[1]},#{coodinates[0]}"
      robot.adapter.notice msg.envelope, "#{place.description}"
