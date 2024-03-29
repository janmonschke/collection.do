var Backbone = require('backbone');

module.exports = Backbone.Router.extend({
  containerElement: '.content',

  initialize: function(){
    this.currentView = null;
    Backbone.Router.prototype.initialize.call(this);
  },

  switchToView: function(view){
    var router = this;

    this._leaveCurrentView(function(){
      router._renderViewToContainer(view);
    });
  },

  _renderViewToContainer: function(view){
    view.render();

    if(this.currentView)
      this.currentView.el.remove();

    Backbone.$(this.containerElement).prepend(view.el);
    this.currentView = view;

    if(view.enter)
      view.enter();
  },

  _leaveCurrentView: function(done){
    var router = this;
    if(router.currentView)
      router.currentView.leave(function(){
        delete router.currentView;
        done();
      });
    else
      done();
  }
});