define(
  ['jQuery', 'Underscore', 'Backbone', 'ItemView'],
  function($, _, Backbone, ItemView){
    return Backbone.View.extend({
      el: "#listView",
      itemClass: ItemView,

      initialize: function(){
        this.collection.on("add remove reset", this.render, this);
      },

      render: function(){
        var models = this.collection.models;
        $(this.el).html("");
        if(models.length > 0){
          _.each(models, this.addItemView, this);
        }else{
          $(this.el).html("No items");
        }
      },

      addItemView: function(model){
        var view = new this.itemClass({ model: model });
        $(this.el).append(view.render().$el);
      },

      destroy: function(){
        this.collection.off("add remove reset", this.render);
        Backbone.View.prototype.destroy.call(this);
      }
    });
  }
);