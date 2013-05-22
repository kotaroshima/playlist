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
        'click .play-item-view': 'onPlayItemClicked'
        'click .delete-icon': 'onRemoveConfirmButtonClicked'
        'click .delete-button': 'onRemoveButtonClicked'

      render:->
        @$el.html @template @model.attributes
        @

      ###
      * Click event handler for play list item
      * Play the song corresponding to this view
      ###
      onPlayItemClicked:->
        Backbone.trigger 'PLAYER_PLAY', @model
        Backbone.trigger 'SHOW_NOW_PLAYING_VIEW'
        return

      ###
      * Click event handler for remove confirm icon
      * switches to remove confirm mode
      ###
      onRemoveConfirmButtonClicked:(e)->
        bRemoveConfirm = @$el.hasClass CLS_REMOVE_CONFIRM
        @$el.toggleClass CLS_REMOVE_CONFIRM, !bRemoveConfirm
        e.stopPropagation()
        return

      ###
      * Click event handler for [Remove] button
      * removes this item from play list
      ###
      onRemoveButtonClicked:(e)->
        @model.destroy()
        e.stopPropagation()
        return
)