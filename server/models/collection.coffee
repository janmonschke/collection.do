connection = require('../database_connection')()
db = connection.database('collection-data')

module.exports =
  get: (id, cb) ->
    db.get(String(id), cb)

  byUserId: (userId, cb) ->
    db.view 'collection/collectionByOwnerId', { key: userId }, (err, res) ->
      if err?
        return cb(err, null)
      cb null, res.map (doc) -> doc