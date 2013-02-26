define(
  ['Underscore', 'ItemView', 'text!template/PlayItemView.html', 'SoundPlayer'],
  function(_, ItemView, viewTemplate, player){
    return ItemView.extend({
      template: _.template(viewTemplate),

      events: {
        "click .playBtn": "onPlayButtonClicked",
        "click .removeBtn": "onRemoveButtonClicked"
      },

      onPlayButtonClicked: function(){
        player.play(this.model);
        // TODO : need to set index
      },

      onRemoveButtonClicked: function(){
        if(confirm(_.template("Are you sure you want to delete '<%=title%>'?", this.model.attributes))){
          pubsub.trigger("PLAY_LIST_ITEM_REMOVED", this.model);
          this.model.destroy();
        }
      }
    });
  }
);