// Global Snapshot View
Snapshot.Views.PhotosView = Backbone.View.extend({

  initialize: function(){
    var allPhotosView = new Snapshot.Views.Photos({ collection: Snapshot.photos}).render();
    $('.photo-view').append(allPhotosView.el);
    // $('.photo-view').html(allPhotosView.el);
  },

  render: function() {  
    return this;
  }
});
// Global Snapshot View
Snapshot.Views.SectorsView = Backbone.View.extend({

  initialize: function(){
    var allSectorsView = new Snapshot.Views.Sectors({ collection: Snapshot.sectors}).render();
    $('#sector-accord').html(allSectorsView.el);
  },

  render: function() {  
    return this;
  }
});

// Global Snapshot View
Snapshot.Views.RetailersView = Backbone.View.extend({

  initialize: function(){
    var allRetailersView = new Snapshot.Views.Retailers({ collection: Snapshot.retailers}).render();
    $('#retailers-accord').html(allRetailersView.el);
  },

  render: function() {  
    return this;
  }
});

// Global Snapshot View
Snapshot.Views.CategoriesView = Backbone.View.extend({

  initialize: function(){
    var allCategoriesView = new Snapshot.Views.Categories({ collection: Snapshot.categories}).render();
    $('#categories').html(allCategoriesView.el);
  },

  render: function() {  
    return this;
  }
});