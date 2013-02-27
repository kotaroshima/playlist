/*
 * A view for each items in the play list
 */
define(
  ['Underscore', 'ItemView', 'text!template/PlayItemView.html', 'SoundPlayer'],
  function(_, ItemView, viewTemplate, player){
    return ItemView.extend({
      template: _.template(viewTemplate),

      events: {
        "click .playBtn": "onPlayButtonClicked",
        "click .removeBtn": "onRemoveButtonClicked"
      },

      /*
       * click event handler for [Play] button
       * Play the song corresponding to this view
       */
      onPlayButtonClicked: function(){
        player.play(this.model);
        pubsub.trigger("PLAYLIST_ITEM_SET_INDEX", this.model);
      },

      /*
       * click event handler for [Remove] button
       * removes this item from play list
       */
      onRemoveButtonClicked: function(){
        if(confirm(_.template("Are you sure you want to delete '<%=title%>'?", this.model.attributes))){
          pubsub.trigger("PLAYLIST_ITEM_REMOVED", this.model);
          this.model.destroy();
        }
      }
    });
  }
);