// setup the app
require('./app_setup.js')

// require base modules
var Backbone = require('backbone');
var AsyncRouter = require('./async_router');
var CollectionsCollection = require('./models/collections_collection');
var CollectionsView = require('./views/collections_view');

// create the router
var Router = AsyncRouter.extend({
  routes: {
    'me': 'me'
  },

  me: function(){
    var collections = new CollectionsCollection();
    var collectionsView = new CollectionsView({collection: collections});
    collections.fetch().done(function(){
      this.switchToView(collectionsView);
    }.bind(this));
  }
})

var router = new Router();

Backbone.history.start({pushState: true});