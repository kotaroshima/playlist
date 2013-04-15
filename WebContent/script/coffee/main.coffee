requirejs.config
  paths:
    text: ['http://cdnjs.cloudflare.com/ajax/libs/require-text/2.0.3/text']
    jQuery: ['http://cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery']
    jQueryUI: ['http://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.10.2/jquery-ui']
    jQueryUITouchPunch: ['http://cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.2/jquery.ui.touch-punch.min']
    Underscore: ['http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.3.3/underscore-min']
    Backbone: ['http://cdnjs.cloudflare.com/ajax/libs/backbone.js/1.0.0/backbone']
    Backpack: ['lib/backpack/Backpack-all']
    SoundCloud: ['http://connect.soundcloud.com/sdk']
    SoundCloudAPI: ['https://w.soundcloud.com/player/api']
  shim:
    text:
      exports: 'text'
    jQuery:
      exports: '$'
    jQueryUI:
      deps: ['jQuery']
      exports: '$'
    jQueryUITouchPunch:
      deps: ['jQuery', 'jQueryUI']
      exports: '$'
    Underscore:
      exports: '_'
    Backbone:
      deps: ['Underscore', 'jQuery']
      exports: 'Backbone'
    Backpack:
      deps: ['jQuery', 'Underscore', 'Backbone']
      exports: 'Backpack'
    SoundCloud:
      exports: 'SC'
    SoundCloudAPI:
      deps: ['SoundCloud']
      exports: 'SC'

require(
  ['Backpack', 'SongItemView', 'PlayListContainerView', 'SoundPlayer'],
  (Backpack, SongItemView, PlayListContainerView, SoundPlayer)->
    ### override so that it won't try to save to server ###
    Backbone.sync =->

    player = SoundPlayer.getInstance()

    $('#showPlayListButton').on 'click', ->
      Backbone.trigger 'SHOW_PLAYLIST'
      return

    collection = new Backpack.Collection null,
      model: Backpack.Model

    new Backpack.ListView
      collection: collection
      el: '#songListView'
      itemClass: SongItemView

    new PlayListContainerView
      el: '#playListContainerView'
      subscribers:
        SHOW_PLAYLIST: 'open'

    player.setup (tracks)->
      collection.reset tracks
      return

    $('#searchBtn').click (e)->
      player.search $('#searchBox').val(), (tracks)->
        collection.reset tracks
        return
      return
    return
)