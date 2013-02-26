define(
  ['Underscore', 'ItemView', 'text!template/SongItemView.html', 'SoundPlayer'],
  function(_, ItemView, viewTemplate, player){
    return ItemView.extend({
      template: _.template(viewTemplate),

      events: {
        "click .playBtn": "onPlayButtonClicked",
        "click .addBtn": "onAddButtonClicked"
      },

      add2PlayList: function(){
        pubsub.trigger("ADD_PLAY_LIST_ITEM", this.model.clone());
        this.$el.addClass('playListAdded');
      },

      onPlayButtonClicked: function(){
        player.play(this.model);
        this.add2PlayList();
      },

      onAddButtonClicked: function(){
        this.add2PlayList();
      }
    });
  }
);