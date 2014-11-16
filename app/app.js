// setup the app
require('./app_setup.js')

// require base modules
var Backbone = require('backbone');
var AsyncRouter = require('./async_router');
var CollectionModel = require('./models/collection_model');
var CollectionsCollection = require('./models/collections_collection');
var ItemsCollection = require('./models/items_collection');
var ItemsView = require('./views/items_view');
var CollectionsView = require('./views/collections_view');

// create the router
var Router = AsyncRouter.extend({
  routes: {
    'me': 'me',
    'user/:ownerId/collection/:collectionId': 'collection'
  },

  me: function(){
    var collections = new CollectionsCollection();
    var collectionsView = new CollectionsView({collections: collections});
    collections.fetch().done(function(){
      this.switchToView(collectionsView);
    }.bind(this));
  },

  collection: function(ownerId, collectionId){
    var collection = new ItemsCollection();
    collection.ownerId = ownerId;
    collection.collectionId = collectionId;

    collection.fetch().done(function(){
      this.switchToView(new ItemsView({collection: collection}));
    }.bind(this));
  }
})

var router = new Router();

Backbone.history.start({pushState: true});