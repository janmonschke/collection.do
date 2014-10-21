request = require 'request'
config = require('./config/services_config')
connection = require('../database_connection')()
db = connection.database('collection-embedly-cache')

module.exports = class Embedly

  @key: config.embedly.key

  @get: (url, done) ->
    @_getFromCache url, (err, data) =>
      if err or not data
        @_getFromEmbedlyApi(url, done)
      else
        done null, data

  # get a single doc or multiple docs from the cache database
  @_getFromCache: (url, done) ->
    db.get url, done

  # get a single doc or multiple docs from the embedly API
  @_getFromEmbedlyApi: (url, done) ->
    api_url = "http://api.embed.ly/1/oembed?key=#{@key}&autoplay=true&url=#{encodeURIComponent(url)}"
    request api_url, (err, response, body) =>
      return done(err) if err
      # TODO check if the url which is returned
      body = JSON.parse body

      @_getFromCache (body.url or url), (err, data) =>
        if err or not data
          @_createFromApiResponse body, done
        else
          done null, data

  @_createFromApiResponse: (embedlyResponse, done) ->
    db.save embedlyResponse.url, embedlyResponse, (err, res) ->
      return done(err) if err
      embedlyResponse._id = res.id
      embedlyResponse._rev = res.rev
      done null, embedlyResponse