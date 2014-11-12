Controller = require('./controller')
Collection = require('../models/collection')
Embedly = require('../models/embedly')
Item = require('../models/item')

class CollectionController extends Controller
  before: ->
    'index' : @ensureAuthenticated
    'create' : @ensureAuthenticated

  index: (req, res) ->
    if req.xhr
      Item.byCollectionId req.params.collection_id, (err, docs) ->
        res.json docs
    else
      res.render 'user'

  create: (req, res) =>
    currUserId = req.user._id
    collectionId = req.params.collection_id
    url = req.body.url

    return @['400'](req, res) unless url

    baseItem =
      collection_id: collectionId
      url: url

    Collection.get collectionId, (err, collection) =>
      return @['500'](req, res) if err
      return @['404'](req, res) if not collection
      return @['403'](req, res) if collection.shared_with.indexOf(currUserId) is -1 and collection.owner_id isnt currUserId

      Embedly.get url, (err, embedly) =>
        return @['500'](req, res) if err
        return @['404'](req, res) if not embedly

        baseItem.content = embedly

        Item.create baseItem, (err, item) =>
          return @['500'](req, res) if err or not item
          res.json item

module.exports = CollectionController