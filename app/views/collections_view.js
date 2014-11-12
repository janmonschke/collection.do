var _ = require('underscore');
var ApplicationView = require('./application_view');

var template = _.template("\
  <form class='js-new-collection'>\
    <input class='collection--input', type='text' placeholder='Create a new collection' /> \
  </form> \
  <% collections.forEach(function(collection) { %> \
    <a class='collection--title-link' href='/user/<%= collection.owner_id %>/collection/<%= collection._id %>'><%= collection.title %></a> \
  <% }) %>")

module.exports = ApplicationView.extend({
  events: {
    'submit .js-new-collection': 'createNewCollection'
  },

  initialize: function(options){
    this.collection = options.collection;
  },

  template: template,

  getRenderData: function(){
    return { collections: this.collection.toJSON() };
  },

  createNewCollection: function(event){
    event.preventDefault();
    console.log(this.$('.collection--input').val());
  }
});