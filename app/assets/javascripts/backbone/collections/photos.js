Snapshot.Collections.Photos = Backbone.Collection.extend({
  model: Snapshot.Models.Photo,
  url: '/photos/search.json'
  
});