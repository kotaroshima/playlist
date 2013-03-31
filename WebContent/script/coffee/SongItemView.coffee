# A view for each songs in the main page
define(
  ['Underscore', 'Backpack', 'text!template/SongItemView.html', 'SoundPlayer'],
  (_, Backpack, viewTemplate, player)->
    Backpack.View.extend
      template: _.template viewTemplate

      events:
        "click .playBtn": "onPlayButtonClicked"
        "click .addBtn": "onAddButtonClicked"

      render:->
        attrs = @model.attributes
        @$el.html @template attrs
        @

      # Notifies collection to add model, and update visual of [Play] button
      # @param [boolean] isPlay : If false, simply adds to the collection. If true, inserts to after currently playing index
      add2PlayList:(isPlay)->
        Backbone.trigger "PLAYLIST_ITEM_ADDED", @model.clone(), isPlay
        @$el.addClass 'playListAdded'
        return

      # click event handler for play button
      # plays the song and adds a song to the play list
      onPlayButtonClicked:->
        player.play @model
        @add2PlayList true
        return

      # click event handler for add button
      # adds a song to the play list
      onAddButtonClicked:->
        @add2PlayList false
        return
)