var Backbone = require('backbone');

module.exports = Backbone.View.extend({
  autoRender: false,

  initialize: function(){
    if(this.autoRender == true)
      this.render();
  },

  // The template function for this view
  //
  // @param data [Object] data for this template
  // @return [String] a DOM-String
  template: function(data){
    return '';
  },

  // Is used to prepare the data for the template function.
  // By default it returns this.model.toJSON() if a model is set
  // @return [Object] data for the template
  getRenderData: function(){
    if(this.model)
      return this.model.toJSON();
    else
      return {};
  },

  // Renders the template to the element and also renders all subviews
  // @return [View] this view
  render: function(){
    this.$el.html(this.template(this.getRenderData()));
    this.afterRender();
    return this.$el;
  },

  // Is called after the view has been rendered
  afterRender: function(){}
});