define(
  ['Backpack', 'SongItemView', 'SoundPlayer', 'text!template/SongListContainerView.html'],
  (Backpack, SongItemView, SoundPlayer, viewTemplate)->
    player = SoundPlayer.getInstance()

    Backpack.View.extend
      template: _.template viewTemplate
      events:
        'click #show-playlist-button': 'onPlayListButtonClicked'
        'click .now-playing-button': 'onNowPlayingButtonClicked'
        'click #search-button': 'onSearchButtonClicked'

      initialize:(options)->
        Backpack.View::initialize.apply @, arguments
        @render()

        @searchBox = @$ '#search-box'
        @searchBox.keyup (e)=>
          if e.which == 13
            @search @searchBox.val()
          return

        collection = @collection = new Backpack.Collection null,
          model: Backpack.Model

        songListView = new Backpack.ListView
          collection: collection
          itemView: SongItemView
          itemOptions:
            onSongItemClicked:->
              model = @model.clone()
              Backbone.trigger 'PLAYLIST_ITEM_INSERT', model
              Backbone.trigger 'PLAYER_PLAY', model
              Backbone.trigger 'SHOW_VIEW', 'nowPlayingView'
              @$el.addClass 'playlist-added'
              return
          subscribers:
            SONGLIST_LOADING: 'setLoading'
        @$('#song-list-view').append songListView.$el

        player.setup $('#embed-container'), (tracks)->
          collection.reset tracks
          return
        return

      render:->
        @$el.html @template()
        @

      onPlayListButtonClicked:->

      onNowPlayingButtonClicked:->

      onSearchButtonClicked:->
        @search @searchBox.val()
        return

      search:(searchString)->
        player.loadTracks { q: searchString }, (tracks)=>
          @collection.reset tracks
          return
        return
)