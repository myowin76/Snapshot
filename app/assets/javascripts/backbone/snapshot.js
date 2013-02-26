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
  initialize: function() {
    //return alert('Hello from Backbone!');
  }
};

$(document).ready(function() {
  return Snapshot.initialize();
});
