###
* A view which displays now playing song
###
define(
  ['Underscore', 'Backpack', 'text!template/NowPlayingView.html'],
  (_, Backpack, viewTemplate)->
    Backpack.View.extend
      template: _.template viewTemplate

      events:
        'click #now-playing-back-button': 'onBackButtonClicked'

      subscribers:
        'PLAYER_PLAY': 'render'

      render:(model)->
        @$el.html @template model.attributes
        @

      onBackButtonClicked:->
)