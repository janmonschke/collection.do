request = require('request')
config = require('../config/services_config')
connection = require('../database_connection')()

module.exports =
  key: config.embedly.key

  # get a single doc or multiple docs from the embedly API
  get: (url, done) ->
    api_url = "http://api.embed.ly/1/oembed?key=#{@key}&autoplay=true&url=#{encodeURIComponent(url)}"
    request api_url, (err, response, body) =>
      return done(err) if err
      # TODO check if the url which is returned
      body = JSON.parse body
      done null, body