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
        attr = _.extend @model.attributes,
          formatDuration:(duration)->
            duration = Math.floor duration/1000
            ret = ''
            h = parseInt duration/3600
            if h > 0
              ret += h+':'+('0'+parseInt((duration-3600*h)/60)).slice(-2)
            else
              ret += parseInt duration/60
            ret += ':'+('0'+(duration%60)).slice(-2)
        @$el.html @template attr
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