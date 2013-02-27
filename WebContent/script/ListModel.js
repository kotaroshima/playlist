/*
 * A base model that doesn't communicate with the server
 */
define(
  ['Backbone'],
  function(Backbone){
    return Backbone.Model.extend({
      // override so that it won't try to persist in the server
      sync: function(){}
    });
  }
);