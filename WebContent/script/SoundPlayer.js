/*
 * A singleton class that manages interaction with SoundCloud APIs
 */
define(
  ['SoundCloudAPI'],
  function(SC){
    var instance = null;

    function SoundPlayer(){
      if(instance){
        throw new Error("Only one instance can be instantiated.");
      }
      this.initialize();
    }

    /*
     * Constructor
     */
    SoundPlayer.prototype.initialize = function(){
      // initialize client with app credentials
      SC.initialize({
        client_id: '8ef8b80025535d68a51f4ee5c3343fc0',
        redirect_uri: 'http://kotaroshima.github.com/playlist/WebContent/callback.html'
      });

      this.domNode = document.getElementById('embedContainer');
    };

    SoundPlayer.getInstance = function(){
      if(!instance){
        instance = new SoundPlayer();
      }
      return instance;
    };

    /*
     * Initialization
     */
    SoundPlayer.prototype.setup = function(callback){
      // by default, show tracks ordered by 'hotness'
      SC.get('/tracks',
        { order: 'hotness', limit: 10, filter: 'streamable' },
        callback
      );
    };

    /*
     * Plays sound
     */
    SoundPlayer.prototype.play = function(model){
      pubsub.trigger("SONG_START", model);
      var url = model.get("uri");
      if(!this._playerInit){
        // embed player widget
        var self = this;
        SC.oEmbed(url, {auto_play: true}, function(response){
          self.domNode.innerHTML = response.html;

          // connect to 'SC.Widget.Events.FINISH' to notify to play next song
          var widget = self._widget = SC.Widget($('#embedContainer IFRAME').get(0));
          widget.bind(SC.Widget.Events.FINISH, function(){
            pubsub.trigger("SONG_FINISHED");
          });
          self._playerInit = true;
          widget.play(); // call play explicitly, because somehow 'auto_play' didn't work in iPhone
        });
      }else{
        // already embedded to updates url and plays
        this._widget.load(url, {auto_play: true});
        this._widget.play(); // call play explicitly, because somehow 'auto_play' didn't work in iPhone
      }
    };

    /*
     * Searches for songs with a keyword
     */
    SoundPlayer.prototype.search = function(searchString, callback){
      SC.get('/tracks', { q: searchString }, callback);
    };

    return SoundPlayer.getInstance();
  }
);