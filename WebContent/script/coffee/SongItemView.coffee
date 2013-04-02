# A view for each songs in the main page
define(
  ['Underscore', 'Backpack', 'text!template/SongItemView.html', 'SoundPlayer'],
  (_, Backpack, viewTemplate, player)->
    Backpack.View.extend
      template: _.template viewTemplate

      events:
        'click .playBtn': 'onPlayButtonClicked'
        'click .addBtn': 'onAddButtonClicked'

      render:->
        attrs = @model.attributes
        @$el.html @template attrs
        @

      # click event handler for play button
      # plays the song and adds a song to the play list
      onPlayButtonClicked:->
        model = @model.clone()
        Backbone.trigger 'PLAYLIST_ITEM_INSERT', model
        player.play model
        @$el.addClass 'playListAdded'
        return

      # click event handler for add button
      # adds a song to the play list
      onAddButtonClicked:->
        Backbone.trigger 'PLAYLIST_ITEM_ADD', @model.clone()
        @$el.addClass 'playListAdded'
        return
)