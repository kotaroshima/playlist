define(
  ['jQueryUITouchPunch', 'ListView', 'PlayItemView', 'SoundPlayer'],
  function($, ListView, PlayItemView, player){
    return ListView.extend({
      el: "#playListView",
      itemClass: PlayItemView,

      initialize: function(){
        ListView.prototype.initialize.call(this);

        // make list draggable
        this.$el.sortable({
          start: function(event, ui) {
            ui.item.startIndex = ui.item.index();
          },
          stop: function(event, ui){
            pubsub.trigger("MOVE_PLAY_LIST_ITEM", ui.item.startIndex, ui.item.index());
          }
        });

        // when song play finishes, play next song
        var collection = this.collection;
        pubsub.on("SONG_FINISHED", function(){
          var model = collection.next();
          if(model){
            player.play(model);
          }
        });
      }
    });
  }
);