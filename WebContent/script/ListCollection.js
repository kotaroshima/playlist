/*
 * A subclass of Backbone.Collection so that ListModel is used instead of simple model
 */
define(
  ['ListModel'],
  function(ListModel){
    return Backbone.Collection.extend({
      model: ListModel
    });
  }
);