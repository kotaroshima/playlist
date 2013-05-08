# A plugin for Collection
# manages current model within a Collection
define(
  ['jQuery','Underscore'],
  ($,_)->
    setup:->
      @_currentIndex = -1;
      @on 'remove', @onRemoved, @ # if current item gets removed, update index
      return

    # Returns an index within models for a given model
    indexOf:(model)->
      urls = _.map @models, (m)->
        m.get 'uri'
      _.indexOf urls, model.get('uri')

    setCurrentModel:(model)->
      index = @indexOf model
      @setCurrentIndex index
      return

    setCurrentIndex: (index)->
      @_currentIndex = index
      return

    insertAfterCurrent:(model)->
      index = if @_currentIndex == -1 then 0 else @_currentIndex+1
      @add model, { at: index }
      @setCurrentIndex index
      return

    # Increments currently playing index, and returns model corresponding to new index
    next:->
      if @_currentIndex < @length-1
        @setCurrentIndex @_currentIndex+1
        @at @_currentIndex
      else
        @setCurrentIndex -1
        null

    onRemoved:(model)->
      index = @indexOf model
      if index < @_currentIndex
        @setCurrentIndex @_currentIndex-1
      return

    cleanup:->
      @off 'remove', @onRemoved, @
      return
)