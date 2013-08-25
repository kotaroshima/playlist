###
* A view for each songs in the main page
###
define(
  ['Underscore', 'Backpack', 'text!template/SongItemView.html'],
  (_, Backpack, viewTemplate)->
    Backpack.View.extend
      template: _.template viewTemplate

      events:
        'click .song-item-view': 'onSongItemClicked'
        'click .add-button': 'onAddButtonClicked'

      render:->
        attr = _.extend @model.attributes,
          formatDuration:(duration)->
            duration = Math.floor duration/1000
            ret = ''
            h = parseInt duration/3600
            if h > 0
              ret += h+':'+('0'+parseInt((duration-3600*h)/60)).slice(-2)
            else
              ret += parseInt duration/60
            ret += ':'+('0'+(duration%60)).slice(-2)
        @$el.html @template attr
        @

      # click event handler for song list item
      # plays the song and adds a song to the play list
      onSongItemClicked:->
        model = @model.clone()
        Backbone.trigger 'PLAYLIST_ITEM_INSERT', model
        Backbone.trigger 'PLAYER_PLAY', model
        Backbone.trigger 'SHOW_VIEW', 'nowPlayingView'
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