var Backbone = require('backbone');

module.exports = Backbone.Model.extend({
  url: function(){
    return '/user/' + this.ownerId + '/collection/' + this.get('collection_id') + '/items';
  }
});