window.Snapshot.Routers.Sectors = Backbone.Router.extend({
	
	initialize: function(options) {
    // this.el = options.element;
    this.sectors = new Snapshot.Collections.Sectors();
    // this.sectors.fetch();
  },
  
	routes: {
    "": "index",
		"sectors/:id": "show"
  },

  index: function(){
    view = new Snapshot.Views.SectorsIndex();
    // alert("sector index")

  },

  show: function(id){
  	// alert("Sector" + id);
  }
}); 