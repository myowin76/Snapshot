//////// All Categories View
Snapshot.Views.Categories = Backbone.View.extend({
  tagName: 'div',
  className: 'accordion-inner',

  render: function() {
    this.collection.each( this.addOne, this);
    // console.log( this.el )
    return this;
  },

  addOne: function(category){
    var categoryView = new Snapshot.Views.Category({ model: category });
    this.$el.append(categoryView.render().el);
  }

});

// Single Category View
Snapshot.Views.Category = Backbone.View.extend({
  tagName: 'label', 
  className: 'checkbox',
  template: template('categories_view'),

  render: function() {
    this.$el.html( this.template( this.model.toJSON() ) );
    return this;
  }

});

