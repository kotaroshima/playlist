# A base view supporting templates
define(
  ['jQuery', 'Underscore', 'Backpack', 'text!template/ItemView.html'],
  ($, _, Backpack, viewTemplate)->
    Backpack.View.extend
      template: _.template viewTemplate

      render:->
        attrs = @model.attributes
        @$el.html @template attrs
        @
)