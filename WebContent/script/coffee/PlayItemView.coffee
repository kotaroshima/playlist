# A view for each items in the play list
define(
  ['Underscore', 'Backpack', 'text!template/PlayItemView.html'],
  (_, Backpack, viewTemplate)->
    Backpack.View.extend
      template: _.template viewTemplate

      events:
        'click .playBtn': 'onPlayButtonClicked'
        'click .removeBtn': 'onRemoveButtonClicked'

      render:->
        attrs = @model.attributes
        @$el.html @template attrs
        @

      # click event handler for [Play] button
      # Play the song corresponding to this view
      onPlayButtonClicked:->
        Backbone.trigger 'PLAYER_PLAY', @model
        return

      # click event handler for [Remove] button
      # removes this item from play list
      onRemoveButtonClicked:->
        if confirm(_.template('Are you sure you want to delete "<%=title%>"?', @model.attributes))
          @model.destroy()
        return
)