Controller = require('./controller')
Collection = require('../models/collection')

class CollectionController extends Controller
  before: ->
    'create' : @ensureAuthenticated

  create: (req, res) ->

module.exports = CollectionController