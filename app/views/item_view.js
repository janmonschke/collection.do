var _ = require('underscore');
var ApplicationView = require('./application_view');

var template = _.template("\
  <div class='item--headline-container'>\
    <h1 class='item--headline'><%= title %></h1> \
  </div>\
  <div class='item--content'> \
    <img src='<%= thumbnail_url %>' /> \
  </div>\
");

module.exports = ApplicationView.extend({
  template: template,
  className: 'item--wrapper',

  events: {
    'click .item--headline': 'toggleContent'
  },

  toggleContent: function(){
    this.$('.item--content').toggle()
  }
});