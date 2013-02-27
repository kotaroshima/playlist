/*
 * A base view that displays list view
 */
define(
  ['jQuery', 'Underscore', 'Backbone', 'ItemView'],
  function($, _, Backbone, ItemView){
    return Backbone.View.extend({
      el: "#listView",
      itemClass: ItemView,

      initialize: function(){
        this.collection.on("add remove reset", this.render, this);
        this._childViews = [];
      },

      /*
       * Renders this list view
       */
      render: function(){
        var models = this.collection.models;
        this._childViews = [];
        $(this.el).html("");
        if(models.length > 0){
          _.each(models, this.addView, this);
        }else{
          $(this.el).html("No items"); // TODO : i18n
        }
      },

      /*
       * Adds list item to this view
       * @param [Backbone.Model] model : a child model corresponding to child view to be added to this list
       */
      addView: function(model){
        var view = new this.itemClass({ model: model });
        $(this.el).append(view.render().$el);
        this._childViews.push(view);
      },

      /*
       * Get child view in i-th index
       */
      getView: function(index){
        return this._childViews[index];
      },

      destroy: function(){
        this.collection.off("add remove reset", this.render);
        Backbone.View.prototype.destroy.call(this);
      }
    });
  }
);