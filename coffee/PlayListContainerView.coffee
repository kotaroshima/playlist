###
* A view to display/manage playlists
###
CLS_NOW_PLAYING = 'now-playing'
CLS_PLAYLIST_EDIT = 'playlist_edit'

define(
  ['jQueryUITouchPunch', 'Backpack', 'CurrentModelPlugin', 'PlayItemView', 'text!template/PlayListContainerView.html'],
  ($, Backpack, CurrentModelPlugin, PlayItemView, viewTemplate)->
    Backpack.View.extend
      template: _.template viewTemplate # TODO : i18n

      events:
        'click .song-list-button': 'onSongListButtonClicked'
        'click .now-playing-button': 'onNowPlayingButtonClicked'
        'click .edit-button': 'onEditButtonClicked'
        'click .done-button': 'onDoneButtonClicked'

      ###
      * Sets up playlist view
      ###
      initialize:(options)->
        Backpack.View::initialize.apply @, arguments
        @render()

        # setup collection
        collection = new Backpack.Collection null,
          model: Backpack.Model
          plugins: [CurrentModelPlugin]
          subscribers:
            SONG_STARTED: 'setCurrentModel'
            SONG_FINISHED: 'onSongFinished'
            PLAYLIST_ITEM_ADD: 'add'
            PLAYLIST_ITEM_INSERT: 'insertAfterCurrent'
          publishers:
            setCurrentIndex: 'PLAYLIST_INDEX_UPDATED'
          onSongFinished:->
            model = @next()
            if model
              Backbone.trigger 'PLAYER_PLAY', model
            return

        # setup list view
        view = @listView = new Backpack.EditableListView
          collection: collection
          itemView: PlayItemView
          subscribers:
            PLAYLIST_INDEX_UPDATED: 'onCurrentIndexUpdated'
          onCurrentIndexUpdated:(index)->
            if @_nowPlayingView
              @_nowPlayingView.$el.removeClass CLS_NOW_PLAYING
            if index >= 0
              @_nowPlayingView = @getChild index
              @_nowPlayingView.$el.addClass CLS_NOW_PLAYING
            return
        view.render()
        @$('#playlist-view').append view.$el
        return

      ###
      * Renders template HTML
      ###
      render:->
        @$el.html @template()
        @

      ###
      * Click event handler for [Song List] button
      * When clicked, song list page opens
      ###
      onSongListButtonClicked:->

      onNowPlayingButtonClicked:->

      ###
      * Click event handler for [Edit] button
      * Turns on edit mode when clicked
      ###
      onEditButtonClicked:->
        @listView.setEditable true
        @$el.toggleClass CLS_PLAYLIST_EDIT, true
        return

      ###
      * Click event handler for [Edit] button
      * Turns off edit mode when clicked
      ###
      onDoneButtonClicked:->
        @listView.setEditable false
        @$el.toggleClass CLS_PLAYLIST_EDIT, false
        return
)