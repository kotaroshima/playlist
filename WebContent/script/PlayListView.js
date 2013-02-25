define(
  ['ListView', 'PlayItemView'],
  function(ListView, PlayItemView){
    return ListView.extend({
      el: "#playListView",
      itemClass: PlayItemView,

      initialize: function(){
        ListView.prototype.initialize.call(this);

        this.$el.sortable({
          start: function(event, ui) {
            ui.item.startIndex = ui.item.index();
          },
          stop: function(event, ui){
            pubsub.trigger("MOVE_PLAY_LIST_ITEM", ui.item.startIndex, ui.item.index());
          }
        });
      }
    });
  }
);