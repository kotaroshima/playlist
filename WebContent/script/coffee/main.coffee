paths =
  text: ['http://cdnjs.cloudflare.com/ajax/libs/require-text/2.0.3/text']
  jQuery: ['http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min']
  jQueryUI: ['http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/jquery-ui.min']
  jQueryUITouchPunch: ['http://cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.2/jquery.ui.touch-punch.min']
  Underscore: ['http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.3.3/underscore-min']
  Backbone: ['http://cdnjs.cloudflare.com/ajax/libs/backbone.js/0.9.9/backbone-min']
  Backpack: ['lib/backpack/Backpack']
  'backpack/components/ListView': ['lib/backpack/components/ListView']
  'backpack/plugins/Subscribable': ['lib/backpack/plugins/Subscribable']
  'backpack/plugins/Sortable': ['lib/backpack/plugins/Sortable']
  SoundCloud: ['http://connect.soundcloud.com/sdk']
  SoundCloudAPI: ['https://w.soundcloud.com/player/api']

shim =
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
  SoundCloud:
    exports: 'SC'
  SoundCloudAPI:
    deps: ['SoundCloud']
    exports: 'SC'

requirejs.config { paths: paths, shim: shim }

require(
  ['jQueryUI', 'Underscore', 'Backbone', 'ListModel', 'backpack/components/ListView', 'SongItemView', 'PlayListContainerView', 'SoundPlayer'],
  ($, _, Backbone, ListModel, ListView, SongItemView, PlayListContainerView, player)->
    $('#showPlayListButton').on 'click', ->
      Backbone.trigger "SHOW_PLAYLIST"
      return

    collection = new Backbone.Collection model: ListModel
    new ListView collection: collection, el: '#songListView', itemClass: SongItemView
    new PlayListContainerView()

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