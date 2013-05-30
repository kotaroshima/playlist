# A view for each songs in the main page
define(
  ['Underscore', 'Backpack', 'text!template/SongItemView.html'],
  (_, Backpack, viewTemplate)->
    Backpack.View.extend
      template: _.template viewTemplate

      events:
        'click .song-item-view': 'onSongItemClicked'
        'click .add-button': 'onAddButtonClicked'

      render:->
        attrs = @model.attributes
        @$el.html @template attrs
        @

      # click event handler for song list item
      # plays the song and adds a song to the play list
      onSongItemClicked:->
        model = @model.clone()
        Backbone.trigger 'PLAYLIST_ITEM_INSERT', model
        Backbone.trigger 'PLAYER_PLAY', model
        Backbone.trigger 'SHOW_NOW_PLAYING_VIEW'
        @$el.addClass 'playlist-added'
        return

      # click event handler for add button
      # adds a song to the play list
      onAddButtonClicked:(e)->
        Backbone.trigger 'PLAYLIST_ITEM_ADD', @model.clone()
        @$el.addClass 'playlist-added'
        e.stopPropagation()
        return
)