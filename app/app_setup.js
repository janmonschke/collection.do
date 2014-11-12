var _ = require('underscore');
var jQuery = require('jquery');
var Backbone = require('backbone');

// tell Backbone about the jQuery version we're using
Backbone.$ = jQuery;

// tell Backbone to use _id instead of id
Backbone.Model.prototype.idAttribute = '_id';