// Generated by CoffeeScript 1.6.2
(function() {
  define(['Backpack', 'SongItemView', 'SoundPlayer', 'text!template/SongListContainerView.html'], function(Backpack, SongItemView, SoundPlayer, viewTemplate) {
    return Backpack.View.extend({
      template: _.template(viewTemplate),
      events: {
        'click #showPlayListButton': 'onPlayListButtonClicked',
        'click #searchBtn': 'onSearchButtonClicked'
      },
      initialize: function(options) {
        var collection, songListView;

        Backpack.View.prototype.initialize.apply(this, arguments);
        this.render();
        collection = this.collection = new Backpack.Collection(null, {
          model: Backpack.Model
        });
        songListView = new Backpack.ListView({
          collection: collection,
          itemClass: SongItemView,
          subscribers: {
            SONGLIST_LOADING: 'setLoading'
          }
        });
        this.$('#songListView').append(songListView.$el);
        SoundPlayer.getInstance().setup(this.$('#embedContainer'), function(tracks) {
          collection.reset(tracks);
        });
      },
      render: function() {
        this.$el.html(this.template());
        return this;
      },
      onPlayListButtonClicked: function() {},
      onSearchButtonClicked: function() {
        var _this = this;

        SoundPlayer.getInstance().loadTracks({
          q: $('#searchBox').val()
        }, function(tracks) {
          _this.collection.reset(tracks);
        });
      }
    });
  });

}).call(this);