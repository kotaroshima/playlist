define(
  ['Underscore', 'ItemView', 'text!template/PlayItemView.html'],
  function(_, ItemView, viewTemplate){
    return ItemView.extend({
      template: _.template(viewTemplate),

      events: {
        "click .removeBtn": "onRemoveButtonClicked"
      },

      onRemoveButtonClicked: function(){
        if (confirm(_.template("Are you sure you want to delete '<%=name%>'?", this.model.attributes))) {
          return this.model.destroy();
        }
      }
    });
  }
);