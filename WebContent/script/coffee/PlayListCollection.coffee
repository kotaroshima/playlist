# A Backbone collection with the following functionalities added
# - moving of models
# - managing index of current song being played
define(
  ['Underscore', 'Backpack', 'SoundPlayer'],
  (_, Backpack, player)->
    Backpack.Collection.extend

      initialize:(models, options)->
        Backpack.Collection::initialize.apply @, arguments

        @index = -1;

        Backbone.on "PLAYLIST_ITEM_ADDED", (model, isPlay)=>
          options = null
          if isPlay
            if @index == -1
              # no song is playing, so insert to the front of the play list
              options = { at: 0 }
            else
              # currently some song is playing, so insert to after the currently playing song
              options = { at: @index+1 }
          @add model, options
          if options
            @setIndex options.at
          return

        # if current item gets removed, update index
        @on "remove", @onRemoved, @

        Backbone.on "PLAYLIST_ITEM_SET_INDEX", (model)=>
          @setCurrentModel model
          return

      # Returns an index within models for a given model
      indexOf: (model)->
        urls = _.map @models, (m)->
          m.get 'uri'
        _.indexOf urls, model.get('uri')
        return

      onRemoved:(model)->
        index = @indexOf model
        if index < @index
          @setIndex @index-1
        return

      setCurrentModel:(model)->
        index = @indexOf model
        @setIndex index
        return

      setIndex: (index)->
        @index = index
        Backbone.trigger "PLAYLIST_INDEX_UPDATED", index
        return

      # Increments currently playing index, and returns model corresponding to new index
      next:->
        if @index < @length-1
          @setIndex @index+1
          @at @index
        else
          @setIndex -1
          null

      onSongFinished:->
        model = @next()
        if model
          player.play model
        return
)