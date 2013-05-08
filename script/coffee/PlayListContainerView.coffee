###
* A view to display/manage playlists
###
CLS_PLAYLIST_EDIT = 'playlist-edit'
CLS_NOW_PLAYING = 'now-playing'

define(
  ['jQueryUITouchPunch', 'Backpack', 'CurrentModel', 'PlayItemView', 'text!template/PlayListContainerView.html'],
  ($, Backpack, CurrentModel, PlayItemView, viewTemplate)->
    Backpack.View.extend
      template: _.template viewTemplate # TODO : i18n

      events:
        'click .song-list-button': 'onSongListButtonClicked'
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
          plugins: [CurrentModel]
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
        view = @listView = new Backpack.ListView
          collection: collection
          itemClass: PlayItemView
          plugins: [Backpack.Container, Backpack.Sortable]
          subscribers:
            PLAYLIST_INDEX_UPDATED: 'onCurrentIndexUpdated'
          sortable: false
          sortableOptions:
            handle: ".reorder-handle"
          onCurrentIndexUpdated:(index)->
            if @_nowPlayingView
              @_nowPlayingView.$el.removeClass CLS_NOW_PLAYING
            if index >= 0
              @_nowPlayingView = @getChild index
              @_nowPlayingView.$el.addClass CLS_NOW_PLAYING
            return
        view.render()
        @$('#playlist-view').append view.$el

        # turn off edit mode
        @setEditMode false
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

      ###
      * Turn on/off edit mode
      * When in edit mode, allows deleting/drag & drop play list items
      * @param {Boolean} bEdit if true, turns on edit mode. If false, turns off edit mode.
      ###
      setEditMode:(bEdit)->
        @listView.setSortable bEdit
        if bEdit
          @$el.addClass CLS_PLAYLIST_EDIT
        else
          @$el.removeClass CLS_PLAYLIST_EDIT
        return

      ###
      * Click event handler for [Edit] button
      * Turns on edit mode when clicked
      ###
      onEditButtonClicked:->
        @setEditMode true
        return

      ###
      * Click event handler for [Edit] button
      * Turns off edit mode when clicked
      ###
      onDoneButtonClicked:->
        @setEditMode false
        return
)