define(
  ['Backbone', 'ListModel'],
  function(Backbone, ListModel){
    return Backbone.Collection.extend({
      model: ListModel,

      move: function(origIndex, newIndex){
        var model = this.at(origIndex);
        this.remove(model);
        this.add(model, { at: newIndex });
      }
    });
  }
);