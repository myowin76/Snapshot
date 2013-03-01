window.Snapshot.Routers.Sectors = Backbone.Router.extend({
	
	initialize: function(options) {
    this.el = options.element;
  },
  
	routes: {
    "": "index",
		"sectors/:id": "show"
  },

  index: function(){
    // alert("home page");
  },

  show: function(id){
  	// alert("Sector" + id);
  }
}); 