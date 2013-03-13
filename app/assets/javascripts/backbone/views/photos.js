// Global Snapshot View
Snapshot.Views.Snapshot = Backbone.View.extend({

  initialize: function(){

    var allPhotosView = new Snapshot.Views.Photos({ collection: Snapshot.photos}).render();
    $('.photo-view').append(allPhotosView.el);
  },

  render: function() {  
    return this;
  }
});

// All Photos View
Snapshot.Views.Photos = Backbone.View.extend({
  tagName: 'ul',
  id: 'photos-viewer',
  className: 'photos-viewer row-fluid',

  render: function() {
    this.collection.each( this.addOne, this);
    // console.log( this.el )
    return this;
  },

  addOne: function(photo){
    var photoView = new Snapshot.Views.Photo({ model: photo });
    console.log(  photoView.render().el );
    this.$el.append(photoView.render().el);
  }

});

// Single Photo View
Snapshot.Views.Photo = Backbone.View.extend({
  tagName: 'li', 
   template: template('photos_view'),
   // template: '<li>'+ +'</li>',
  // template: _.template($('#photos_view').html()),

  render: function() {
    this.$el.html( this.template( this.model.toJSON() ) );
    // this.$el.html( this.model.toJSON() );
    return this;
  }

});