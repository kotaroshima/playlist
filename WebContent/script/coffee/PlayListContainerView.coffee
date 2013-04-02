# A view which contains:
# - play list view
# - back to song list button
# It is implemented as a dialog
define(
  ['jQuery','Underscore','Backpack','CurrentModel','backpack/components/ListView','PlayItemView','backpack/plugins/Sortable','text!template/PlayListContainerView.html'],
  ($, _, Backpack, CurrentModel, ListView, PlayItemView, Sortable, viewTemplate)->
    Backpack.View.extend
      template: _.template viewTemplate

      events:
        'click .songListBtn': 'close'

      initialize:(options)->
        Backpack.View::initialize.apply @, arguments
        @render()

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
              player.play model
            return

        view = @listView = new ListView
          collection: collection
          el: '#playListView'
          itemClass: PlayItemView
          plugins: [Sortable]
          subscribers:
            PLAYLIST_INDEX_UPDATED: 'onCurrentIndexUpdated'
          onCurrentIndexUpdated:(index)->
            if @_nowPlayingView
              @_nowPlayingView.$el.removeClass 'now-playing'
            if index isnt -1
              view = @_nowPlayingView = @getChild index
              view.$el.addClass 'now-playing'
            return

        view.render()
        return

      render:->
        @$el.html @template()

        @$el.dialog
          autoOpen: false
          width: $(window).width()
          height: $(window).height()
        @

      open:->
        @$el.dialog 'open'
        return

      close:->
        @$el.dialog 'close'
        return
)