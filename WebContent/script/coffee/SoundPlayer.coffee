# A singleton class that manages interaction with SoundCloud APIs
define(
  ['SoundCloudAPI', 'Backpack'],
  (SC, Backpack)->
    Backpack.Class.extend
      plugins: [Backpack.Singleton]

      initialize:->
        Backpack.Class::initialize.apply @, arguments
        # initialize client with app credentials
        SC.initialize
          client_id: '8ef8b80025535d68a51f4ee5c3343fc0',
          redirect_uri: 'http://kotaroshima.github.com/playlist/WebContent/callback.html'
        Backbone.on 'PLAYER_PLAY', @play, @
        @

      setup:(node, callback)->
        @domNode = node
        # by default, show tracks ordered by 'hotness'
        @loadTracks { order: 'hotness', limit: 10, filter: 'streamable' }, callback
        SC.get '/tracks',
          { order: 'hotness', limit: 10, filter: 'streamable' },
          callback
        return

      play: (model)->
        Backbone.trigger 'SONG_STARTED', model
        url = model.get 'uri'
        if !@_playerInit
          # embed player widget
          SC.oEmbed url, {auto_play: true}, (response)=>
            @domNode.html response.html

            # connect to 'SC.Widget.Events.FINISH' to notify to play next song
            widget = @_widget = SC.Widget $('#embedContainer IFRAME').get(0)
            widget.bind SC.Widget.Events.FINISH, ->
              Backbone.trigger 'SONG_FINISHED'
              return
            @_playerInit = true
            widget.play() # call play explicitly, because somehow 'auto_play' didn't work in iPhone
            return
        else
          # already embedded to updates url and plays
          @_widget.load url, {auto_play: true}
          @_widget.play() # call play explicitly, because somehow 'auto_play' didn't work in iPhone
        return

      # Searches for songs with a keyword
      loadTracks: (options, callback)->
        Backbone.trigger 'SONGLIST_LOADING', true
        SC.get '/tracks', options, (tracks)->
          callback tracks
          Backbone.trigger 'SONGLIST_LOADING', false
          return
        return
)