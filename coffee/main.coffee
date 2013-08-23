requirejs.config
  paths:
    text: ['//cdnjs.cloudflare.com/ajax/libs/require-text/2.0.3/text']
    jQuery: ['//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery']
    jQueryUI: ['//cdnjs.cloudflare.com/ajax/libs/jqueryui/1.10.2/jquery-ui']
    jQueryUITouchPunch: ['//cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.2/jquery.ui.touch-punch.min']
    Underscore: ['//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.4.4/underscore']
    Backbone: ['//cdnjs.cloudflare.com/ajax/libs/backbone.js/1.0.0/backbone']
    Backpack: ['lib/backpack/Backpack-all']
    SoundCloud: ['//connect.soundcloud.com/sdk']
    SoundCloudAPI: ['//w.soundcloud.com/player/api']
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
  ['Backbone', 'SongListContainerView', 'PlayListContainerView', 'NowPlayingView'],
  (Backbone, SongListContainerView, PlayListContainerView, NowPlayingView)->
    ### override so that it won't try to save to server ###
    Backbone.sync =->

    songListContainerView = new SongListContainerView
      name: 'songListContainerView'

    playListContainerView = new PlayListContainerView
      name: 'playListContainerView'

    nowPlayingView = new NowPlayingView
      name: 'nowPlayingView'

    stackView = new Backpack.StackView
      el: '#stack-view'
      children: [songListContainerView, playListContainerView, nowPlayingView]
      navigationEvents:
        songListContainerView: [
          { event: 'onPlayListButtonClicked', target: 'playListContainerView' },
          { event: 'onNowPlayingButtonClicked', target: 'nowPlayingView' }
        ]
        playListContainerView: [
          { event: 'onSongListButtonClicked', target: 'songListContainerView' },
          { event: 'onNowPlayingButtonClicked', target: 'nowPlayingView' }
        ]
        nowPlayingView:
          event: 'onBackButtonClicked'
          back: true
      subscribers:
        SHOW_VIEW: 'showChild'
        PLAYER_PLAY: 'onSongPlayed'
      onSongPlayed:->
        @$el.addClass 'song-played'
        return
    return
)