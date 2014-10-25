var Backbone = require('backbone');
var Collection = require('./collection_model');

module.exports = Backbone.Collection.extend({
  url: '/api/collections',
  model: Collection
});