/*
 * A view which contains:
 * - play list view
 * - back to song list button
 * It is implemented as a dialog
 */
define(
  ['jQuery', 'Underscore', 'Backbone', 'PlayListCollection', 'PlayListView', 'text!template/PlayListContainerView.html'],
  function($, _, Backbone, PlayListCollection, PlayListView, viewTemplate){
    return Backbone.View.extend({
      el: "#playListContainerView",
      template: _.template(viewTemplate),

      events: {
        "click .songListBtn": "close"
      },

      initialize: function(){
        this.render();

        var collection = new PlayListCollection();
        var view = new PlayListView({ collection: collection });
        view.render();

        pubsub.on("SHOW_PLAYLIST", this.open, this);
      },

      render: function(){
        $(this.el).html(this.template());

        this.$el.dialog({
          autoOpen: false,
          width: $(window).width(),
          height: $(window).height()
        });

        return this;
      },

      open: function(){
        this.$el.dialog('open');
      },

      close: function(){
        this.$el.dialog('close');
      },

      destroy: function(){
        pubsub.off("SHOW_PLAYLIST", this.open, this);
        Backbone.View.prototype.destroy.call(this);
      }
    });
  }
);