var _ = require('underscore');
var ApplicationView = require('./application_view');

var template = _.template("\
  <form class='js-new-collection'>\
    <input class='collection--input', type='text' placeholder='Create a new collection' /> \
  </form> \
  <% collections.forEach(function(collection) { %> \
    <a class='collection--title-link' href='/user/<%= collection.owners[0].id %>/collection/<%= collection.id %>'><%= collection.title %></a> \
    <div class='collection--authors'><%= collection.owners_string %></div> \
  <% }) %>")

module.exports = ApplicationView.extend({
  events: {
    'submit .js-new-collection': 'createNewCollection'
  },

  initialize: function(options){
    this.collections = options.collections;
  },

  template: template,

  getRenderData: function(){
    return { collections: this.collections.toJSON() };
  },

  createNewCollection: function(event){
    event.preventDefault();
    var title = this.$('.collection--input').val();

    if(title.length == 0) return

    this.collections.create({
      title: title
    });
  }
});