var _ = require('underscore');
var Backbone = require('backbone');

module.exports = Backbone.Model.extend({
  toJSON: function(){
    var json = Backbone.Model.prototype.toJSON.call(this);
    json.owners_string = _.pluck(json.owners, 'name').join(',');
    return json;
  }
});