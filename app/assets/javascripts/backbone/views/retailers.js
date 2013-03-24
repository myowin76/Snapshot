//////// All Sectors View
Snapshot.Views.Retailers = Backbone.View.extend({
  tagName: 'div',
  className: 'accordion-inner',

  render: function() {
    this.collection.each( this.addOne, this);
    // console.log( this.el )
    return this;
  },

  addOne: function(retailer){
    var retailerView = new Snapshot.Views.Retailer({ model: retailer });
    this.$el.append(retailerView.render().el);
  }

});

// Single Retailer View
Snapshot.Views.Retailer = Backbone.View.extend({
  tagName: 'label', 
  className: 'checkbox',
  template: template('retailers_view'),

  render: function() {
    this.$el.html( this.template( this.model.toJSON() ) );
    return this;
  }

});

