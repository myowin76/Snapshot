//= require_self
//= require_tree ./templates
//= require_tree ./models
//= require_tree ./views
//= require_tree ./routers

window.Snapshot = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  

  initialize: function(options) {
    Snapshot.options = options;
    new Snapshot.Routers.Sectors(options);

	  if (!Backbone.history.started) {
	    Backbone.history.start();
	    Backbone.history.started = true;
	  }  

  }
};

$(document).ready(function() {
  
  return Snapshot.initialize();


});
