connection = require('../database_connection')()
db = connection.database('collection-data')

module.exports =
  byCollectionId: (collectionId, cb) ->
    db.view 'collection/itemByCollectionId', { key: collectionId }, (err, res) ->
      if err?
        return cb(err, null)
      cb null, res.map (doc) -> doc

  create: (itemData, cb) ->
    # don't allow to set an id
    delete itemData._id
    delete itemData.id

    itemData.type = 'item'

    # save the date of creation
    itemData.created_at = Date.now()

    db.save itemData, (err, res) ->
      return done(err) if err

      itemData._rev = res.rev
      itemData._id = res.id

      cb null, itemData