define(
  ['Backbone'],
  (Backbone)->
    Backbone.Model.extend
      # override so that it won't try to persist in the server
      sync:->
)