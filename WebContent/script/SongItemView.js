define(
  ['Underscore', 'ItemView', 'text!template/SongItemView.html'],
  function(_, ItemView, viewTemplate){
    return ItemView.extend({
      template: _.template(viewTemplate),

      events: {
        "click .addBtn": "onAddButtonClicked"
      },

      onAddButtonClicked: function(){
        pubsub.trigger("ADD_PLAY_LIST_ITEM", this.model.clone());
      }
    });
  }
);