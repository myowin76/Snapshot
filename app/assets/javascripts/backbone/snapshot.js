//= require underscore
//= require backbone
//= require_self
//= require_tree ./models
//= require_tree ./collections
//= require_tree ./views
//= require_tree ./routers


(function() {
  _.templateSettings = {
    interpolate : /\{\{(.+?)\}\}/g
  };
  // _.templateSettings = {
  //     interpolate: /\{\{\(.+?)\}\}/g
  //     // escape: /\{\{-([\s\S]+?)\}\}/g,
  //     // evaluate: /\{\{(.+?)\}\}/g
  // };

  window.Snapshot = {
    Models: {},
    Collections: {},
    Views: {},
    Router: {}
  };


  window.vent = _.extend({}, Backbone.Events);

  window.template = function(id) {
    return _.template( $('#' + id).html() );
  };

})();