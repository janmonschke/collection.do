Controller = require('./controller')
Collection = require('../db').models.Collection
User = require('../db').models.User

class CollectionController extends Controller
  before: ->
    'index' : @ensureAuthenticated
    'create' : @ensureAuthenticated

  index: (req, res) ->
    req.user.getCollections(include: [{
      model: User,
      as: 'owners',
      attributes: ['id', 'name']
    }]).complete (err, collections) ->
      res.json collections

  create: (req, res) ->
    collectionData =
      title: req.body.title

    Collection.create(collectionData).complete (err, collection) ->
      req.user.addCollections([collection])
      res.json collection

module.exports = CollectionController