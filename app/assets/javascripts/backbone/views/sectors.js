//////// All Sectors View
Snapshot.Views.Sectors = Backbone.View.extend({
  tagName: 'div',
  className: 'accordion-inner',

  render: function() {
    this.collection.each( this.addOne, this);
    // console.log( this.el )
    return this;
  },

  addOne: function(sector){
    var sectorView = new Snapshot.Views.Sector({ model: sector });
    // console.log(  photoView.render().el );
    this.$el.append(sectorView.render().el);
  }

});

// Single Sector View
Snapshot.Views.Sector = Backbone.View.extend({
  tagName: 'label', 
  attributes: {
    class: 'checkbox'
  },
  
  template: template('sectors_view'),

  render: function() {
    this.$el.html( this.template( this.model.toJSON() ) );
    return this;
  }

});

