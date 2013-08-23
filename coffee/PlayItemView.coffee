###
* A view for each items in the play list
###
define(
  ['Underscore', 'Backpack', 'text!template/PlayItemView.html'],
  (_, Backpack, viewTemplate)->
    Backpack.View.extend
      template: _.template viewTemplate

      events:
        'click .play-item-view': 'onPlayItemClicked'

      initialize:(options)->
        @render()
        return

      render:->
        @$el.html @template @model.attributes
        @

      ###
      * Click event handler for play list item
      * Play the song corresponding to this view
      ###
      onPlayItemClicked:->
        Backbone.trigger 'PLAYER_PLAY', @model
        Backbone.trigger 'SHOW_VIEW', 'nowPlayingView'
        return
)