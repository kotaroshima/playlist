define(
  ['Backpack', 'SongItemView', 'SoundPlayer', 'text!template/SongListContainerView.html'],
  (Backpack, SongItemView, SoundPlayer, viewTemplate)->
    Backpack.View.extend
      template: _.template viewTemplate
      events:
        'click #showPlayListButton': 'onPlayListButtonClicked'
        'click #searchBtn': 'onSearchButtonClicked'

      initialize:(options)->
        Backpack.View::initialize.apply @, arguments
        @render()

        collection = @collection = new Backpack.Collection null,
          model: Backpack.Model

        songListView = new Backpack.ListView
          collection: collection
          itemClass: SongItemView
        @$('#songListView').append songListView.$el

        SoundPlayer.getInstance().setup @$('#embedContainer'), (tracks)->
          collection.reset tracks
          return
        return

      render:->
        @$el.html @template()
        @

      onPlayListButtonClicked:->

      onSearchButtonClicked:->
        SoundPlayer.getInstance().search $('#searchBox').val(), (tracks)=>
          @collection.reset tracks
          return
        return
)