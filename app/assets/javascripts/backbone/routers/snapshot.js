Snapshot.Router = Backbone.Router.extend({
  routes: {
    "": "index",
    "photos/search": "index"
  },

   initialize: function(options) {
// alert("i am working...")
  },

  
  index: function(){
    console.log("this is index page");
  }

});



// window.Snapshot.Routers.Sectors = Backbone.Router.extend({
	
// 	initialize: function(options) {
//     // this.el = options.element;
//     this.sectors = new Snapshot.Collections.Sectors();
//     // this.sectors.fetch();
//   },
  
// 	routes: {
//     "": "index",
// 		"sectors/:id": "show"
//   },

  

//   show: function(id){
//   	// alert("Sector" + id);
//   }
// }); 