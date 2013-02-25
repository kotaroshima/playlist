define(
  ['ListView', 'SongItemView'],
  function(ListView, SongItemView){
    return ListView.extend({
      el: "#songListView",
      itemClass: SongItemView
    });
  }
);