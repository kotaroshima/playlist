/*
 * A list view that displays play list
 */
define(
  ['jQueryUITouchPunch', 'ListView', 'PlayItemView', 'SoundPlayer'],
  function($, ListView, PlayItemView, player){
    return ListView.extend({
      el: "#playListView",
      itemClass: PlayItemView,

      initialize: function(){
        ListView.prototype.initialize.call(this);

        // make the list draggable
        var self = this;
        this.$el.sortable({
          start: function(event, ui) {
            ui.item.startIndex = ui.item.index();
          },
          stop: function(event, ui){
            self.collection.move(ui.item.startIndex, ui.item.index());
          }
        });

        // when song play finishes, play next song
        pubsub.on("SONG_FINISHED", this.onSongFinished, this);

        pubsub.on("PLAYLIST_INDEX_UPDATED", function(index){
          if(self._nowPlayingView){
            self._nowPlayingView.$el.removeClass('now-playing');
          }
          if(index !== -1){
            var view = self._nowPlayingView = self.getView(index);
            view.$el.addClass('now-playing');
          }
        });
      },

      onSongFinished: function(){
        var model = this.collection.next();
        if(model){
          player.play(model);
        }
      },

      destroy: function(){
        pubsub.off("SONG_FINISHED", this.onSongFinished, this);
        ListView.prototype.destroy.call(this);
      }
    });
  }
);