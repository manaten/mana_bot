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
  robot.hear /^(mana_bot.*meshi|めし)$/, (msg)->
    request { uri: MESHIMAP_URL }, (error, response, body)->
      # cheerioでCDATAをパースできないらしいので、除去してからパース http://stackoverflow.com/questions/15472213/nodejs-using-cheerio-parsing-xml-returns-empty-cdata
      $ = cheerio.load body.replace(/<!\[CDATA\[([^\]]+)]\]>/ig, "$1")
      places = $("placemark").map ->
        {
          name: $(this).find('name').text(),
          coordinates: $(this).find('coordinates').text().split(','),
          description: $(this).find('description').text()
        }

      place = places[Math.floor(Math.random() * places.length)]
      robot.adapter.notice msg.envelope, "#{place.name} #{GOOGLE_MAP_URL}#{place.coordinates[1]},#{place.coordinates[0]}"
      robot.adapter.notice msg.envelope, "#{place.description}"
