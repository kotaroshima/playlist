define(
  ['jQuery', 'Underscore', 'Backbone', 'text!template/ItemView.html'],
  function($, _, Backbone, viewTemplate){
    return Backbone.View.extend({
      template: _.template(viewTemplate),

      render: function(){
        var attrs = this.model.attributes;
        $(this.el).html(this.template(attrs));
        return this;
      }
    });
  }
);