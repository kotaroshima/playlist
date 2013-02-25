define(
  ['jQuery', 'Underscore', 'Backbone', 'ListCollection', 'PlayListView', 'text!template/PlayListContainerView.html'],
  function($, _, Backbone, ListCollection, PlayListView, viewTemplate){
    return Backbone.View.extend({
      el: "#playListContainerView",
      template: _.template(viewTemplate),

      events: {
        "click .songListBtn": "close"
      },

      initialize: function(){
        this.render();

        var collection = new ListCollection();
        new PlayListView({ collection: collection });

        // TODO : dummy data
        collection.add([
          { name: 'abc' },
          { name: 'xyz' },
          { name: '123' }
        ]);

        pubsub.on("SHOW_PLAY_LIST", this.open, this);
        pubsub.on("ADD_PLAY_LIST_ITEM", collection.add, collection);
        pubsub.on("MOVE_PLAY_LIST_ITEM", collection.move, collection);
      },

      render: function(){
        $(this.el).html(this.template());

        this.$el.dialog({
          autoOpen: false,
          title: 'Play Lists',
//          width: $(window).width(),
//          height: $(window).height()
          width: 600,
          height: 600
        });

        return this;
      },

      open: function(){
        this.$el.dialog('open');
      },

      close: function(){
        this.$el.dialog('close');
      }
    });
  }
);