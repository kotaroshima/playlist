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

    SoundPlayer.prototype.setup = function(callback){
      // by default, show tracks ordered by 'hotness'
      SC.get('/tracks',
        { order: 'hotness', limit: 10, filter: 'streamable' },
        callback
      );
    };

    SoundPlayer.prototype.play = function(model){
      pubsub.trigger("SONG_START", model);
      var url = model.get("uri");
      console.debug("Play "+url);
      if(!this._playerInit){
/*      SC.stream(url, function(sound){
        console.log("sound:" +sound.toString());
        sound.play();
      });*/
        SC.oEmbed(url, {auto_play: true}, this.domNode);
        var self = this;
        SC.Widget.bind(SC.Widget.Events.FINISH, function(){
          console.debug("SC.Widget.Events.FINISH");
          pubsub.trigger("SONG_FINISHED");
        });
        this._playerInit = true;
      }else{
        SC.Widget.load(url);
      }
    };

    SoundPlayer.prototype.search = function(searchString, callback){
      SC.get('/tracks', { q: searchString }, callback);
    };

    return SoundPlayer.getInstance();
  }
);