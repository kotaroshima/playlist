(function() {
  var paths = {
    text: ['http://cdnjs.cloudflare.com/ajax/libs/require-text/2.0.3/text'],
    jQuery: ['http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min'],
    jQueryUI: ['http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/jquery-ui.min'],
    jQueryUITouchPunch: ['http://cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.2/jquery.ui.touch-punch.min'],
    Underscore: ['http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.3.3/underscore-min'],
    Backbone: ['http://cdnjs.cloudflare.com/ajax/libs/backbone.js/0.9.9/backbone-min'],
    SoundCloud: ['http://connect.soundcloud.com/sdk'],
    SoundCloudAPI: ['https://w.soundcloud.com/player/api']
  };

  var shim = {
    text: {
      exports: 'text'
    },
    jQuery: {
      exports: '$'
    },
    jQueryUI: {
      deps: ['jQuery'],
      exports: '$'
    },
    jQueryUITouchPunch: {
      deps: ['jQuery', 'jQueryUI'],
      exports: '$'
    },
    Underscore: {
      exports: '_'
    },
    Backbone: {
      deps: ['Underscore', 'jQuery'],
      exports: 'Backbone'
    },
    SoundCloud: {
      exports: 'SC'
    },
    SoundCloudAPI: {
      deps: ['SoundCloud'],
      exports: 'SC'
    }
  };

  requirejs.config({ paths: paths, shim: shim });

  define(
    ['jQueryUI', 'Underscore', 'ListCollection', 'SongListView', 'PlayListContainerView', 'SoundPlayer'],
    function($, _, ListCollection, SongListView, PlayListContainerView, player){
      var pubsub = window.pubsub = _.extend({}, Backbone.Events);

      $('#showPlayListButton').on('click', function(){
        pubsub.trigger("SHOW_PLAYLIST");
      });

      var collection = new ListCollection();
      new SongListView({ collection: collection });
      new PlayListContainerView();

      player.setup(function(tracks){
        collection.reset(tracks);
      });

      $('#searchBtn').click(function(e){
        player.search($('#searchBox').val(), function(tracks){
          collection.reset(tracks);
        });
      });
  });
}).call(this);
