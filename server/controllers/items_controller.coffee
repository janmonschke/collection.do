Controller = require('./controller')
Embedly = require('../models/embedly')
Item = require('../db').models.Item
Collection = require('../db').models.Collection
User = require('../db').models.User

class CollectionController extends Controller
  before: ->
    'index' : @ensureAuthenticated
    'create' : @ensureAuthenticated

  index: (req, res) ->
    if req.xhr
      Item.findAll({
        where: {CollectionId: req.params.collection_id},
        order: 'createdAt DESC'
      }).complete (err, items = []) ->
        res.json items
    else
      res.render 'user'

  create: (req, res) =>
    currUserId = req.user._id
    collectionId = req.params.collection_id
    url = req.body.url

    return @['400'](req, res) unless url

    Collection.findAll({
      where: {id: collectionId}
      include: [{
        model: User,
        as: 'owners',
        attributes: ['id', 'name']
      }]
    }).complete (err, collection) =>
      return @['500'](req, res, err) if err
      return @['404'](req, res) if not collection
      # return @['403'](req, res) if collection.shared_with.indexOf(currUserId) is -1 and collection.owner_id isnt currUserId

      Embedly.get url, (err, embedly) =>
        return @['500'](req, res, err) if err
        return @['404'](req, res) if not embedly

        Item.create(embedly).complete (err, item) =>
          return @['500'](req, res, err) if err or not item

          collection.addItems([item])
          res.json item

module.exports = CollectionController