Controller = require('./controller')
Collection = require('../models/collection')
Item = require('../models/item')

class CollectionController extends Controller
  before: ->
    'index' : @ensureAuthenticated
    'create' : @ensureAuthenticated

  index: (req, res) ->
    Collection.byUserId req.user._id, (err, collections) ->
      res.json collections

  create: (req, res) ->

module.exports = CollectionController