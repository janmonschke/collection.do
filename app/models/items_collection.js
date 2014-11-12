var Backbone = require('backbone');
var ItemModel = require('./item_model');

module.exports = Backbone.Collection.extend({
  model: ItemModel,

  url: function(){
    return '/user/' + this.ownerId + '/collection/' + this.collectionId;
  }
});