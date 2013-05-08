requirejs.config
  paths:
    text: ['http://cdnjs.cloudflare.com/ajax/libs/require-text/2.0.3/text']
    jQuery: ['http://cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery']
    jQueryUI: ['http://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.10.2/jquery-ui']
    jQueryUITouchPunch: ['http://cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.2/jquery.ui.touch-punch.min']
    Underscore: ['http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.4.4/underscore']
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
  ['Backbone', 'SongListContainerView', 'PlayListContainerView'],
  (Backbone, SongListContainerView, PlayListContainerView)->
    ### override so that it won't try to save to server ###
    Backbone.sync =->

    songListContainerView = new SongListContainerView
      name: 'songListContainerView'

    playListContainerView = new PlayListContainerView
      name: 'playListContainerView'

    stackView = new Backpack.StackView
      el: '#stackView'
      children: [songListContainerView, playListContainerView]
      selectedIndex: 0
      stackEvents:
        songListContainerView:
          event: 'onPlayListButtonClicked'
          target: 'playListContainerView'
        playListContainerView:
          event: 'onSongListButtonClicked'
          target: 'songListContainerView'
    return
)