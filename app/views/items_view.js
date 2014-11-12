var _ = require('underscore');
var ApplicationView = require('./application_view');
var ItemView = require('./item_view');
var ItemModel = require('../models/item_model');

var template = _.template("\
  <form class='js-add-item'>\
    <input class='collection--input js-item-value', type='text' placeholder='Add a new item' /> \
    <div class='js--loading loading'></div> \
  </form> \
  <div class='collection--item-list'></div>")

module.exports = ApplicationView.extend({
  events: {
    'submit .js-add-item': 'createNewItem'
  },

  initialize: function(options){
    this.items = options.collection;

    _.bindAll(this, 'appendItem');

    this.listenTo(this.items, 'sync', this.hideLoading);
    this.listenTo(this.items, 'add', this.appendItem);
  },

  template: template,

  render: function(){
    ApplicationView.prototype.render.call(this);
    this.items.each(this.appendItem);
  },

  afterRender: function(){
    this.itemList = this.$('.collection--item-list');
  },

  appendItem: function(item){
    this.itemList.prepend(new ItemView({model: item}).render());
  },

  createNewItem: function(event){
    event.preventDefault();

    var item = this.items.create({
      collection_id: this.items.collectionId,
      url: this.$('.js-item-value').val()
    }, {wait: true});

    this.showLoading();

    item.ownerId = this.items.ownerId;
  },

  showLoading: function(){
    this.$('.js--loading').addClass('is-visible');
  },

  hideLoading: function(){
    this.$('.js--loading').removeClass('is-visible');
  }
});