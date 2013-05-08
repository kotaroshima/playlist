###
* A view for each items in the play list
###
CLS_REMOVE_CONFIRM = 'remove-confirm'

define(
  ['Underscore', 'Backpack', 'text!template/PlayItemView.html'],
  (_, Backpack, viewTemplate)->
    Backpack.View.extend
      template: _.template viewTemplate

      events:
        'click .play-button': 'onPlayButtonClicked'
        'click .delete-icon': 'onRemoveConfirmButtonClicked'
        'click .delete-button': 'onRemoveButtonClicked'

      render:->
        @$el.html @template @model.attributes
        @

      ###
      * Click event handler for [Play] button
      * Play the song corresponding to this view
      ###
      onPlayButtonClicked:->
        Backbone.trigger 'PLAYER_PLAY', @model
        return

      ###
      * Click event handler for remove confirm icon
      * switches to remove confirm mode
      ###
      onRemoveConfirmButtonClicked:->
        bRemoveConfirm = @$el.hasClass CLS_REMOVE_CONFIRM
        @$el.toggleClass CLS_REMOVE_CONFIRM, !bRemoveConfirm
        return

      ###
      * Click event handler for [Remove] button
      * removes this item from play list
      ###
      onRemoveButtonClicked:->
        @model.destroy()
        return
)