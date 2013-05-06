# A view for each items in the play list
define(
  ['Underscore', 'Backpack', 'text!template/PlayItemView.html'],
  (_, Backpack, viewTemplate)->
    Backpack.View.extend
      template: _.template viewTemplate

      events:
        'click .play-button': 'onPlayButtonClicked'
        'click .remove-button': 'onRemoveButtonClicked'

      render:->
        attrs = @model.attributes
        @$el.html @template attrs
        @

      ###
      * Click event handler for [Play] button
      * Play the song corresponding to this view
      ###
      onPlayButtonClicked:->
        Backbone.trigger 'PLAYER_PLAY', @model
        return

      ###
      * Click event handler for [Remove] button
      * removes this item from play list
      ###
      onRemoveButtonClicked:->
        if confirm(_.template('Are you sure you want to delete "<%=title%>"?', @model.attributes))
          @model.destroy()
        return
)