# A view for each items in the play list
define(
  ['Underscore', 'Backbone', 'ItemView', 'text!template/PlayItemView.html', 'SoundPlayer'],
  (_, Backbone, ItemView, viewTemplate, player)->
    ItemView.extend
      template: _.template viewTemplate

      events:
        "click .playBtn": "onPlayButtonClicked"
        "click .removeBtn": "onRemoveButtonClicked"

      # click event handler for [Play] button
      # Play the song corresponding to this view
      onPlayButtonClicked:->
        player.play @model
        Backbone.trigger "PLAYLIST_ITEM_SET_INDEX", @model
        return

      # click event handler for [Remove] button
      # removes this item from play list
      onRemoveButtonClicked:->
        if confirm(_.template("Are you sure you want to delete '<%=title%>'?", @model.attributes))
          Backbone.trigger "PLAYLIST_ITEM_REMOVED", @model
          @model.destroy()
        return
)