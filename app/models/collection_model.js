var Backbone = require('backbone');

module.exports = Backbone.Model.extend({
  url: function(){
    return '/user/' + this.get('owner_id') + '/collection/' + this.id;
  }
});