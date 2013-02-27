/*
 * A view for each songs in the main page
 */
define(
  ['Underscore', 'ItemView', 'text!template/SongItemView.html', 'SoundPlayer'],
  function(_, ItemView, viewTemplate, player){
    return ItemView.extend({
      template: _.template(viewTemplate),

      events: {
        "click .playBtn": "onPlayButtonClicked",
        "click .addBtn": "onAddButtonClicked"
      },

      /*
       * Notifies collection to add model, and update visual of [Play] button
       * @param [boolean] isPlay : If false, simply adds to the collection. If true, inserts to after currently playing index
       */
      add2PlayList: function(isPlay){
        pubsub.trigger("PLAYLIST_ITEM_ADDED", this.model.clone(), isPlay);
        this.$el.addClass('playListAdded');
      },

      /*
       * click event handler for play button
       * plays the song and adds a song to the play list
       */
      onPlayButtonClicked: function(){
        player.play(this.model);
        this.add2PlayList(true);
      },

      /*
       * click event handler for add button
       * adds a song to the play list
       */
      onAddButtonClicked: function(){
        this.add2PlayList(false);
      }
    });
  }
);