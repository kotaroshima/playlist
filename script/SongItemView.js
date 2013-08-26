// Generated by CoffeeScript 1.6.2
/*
* A view for each songs in the main page
*/


(function() {
  define(['Underscore', 'Backpack', 'text!template/SongItemView.html'], function(_, Backpack, viewTemplate) {
    return Backpack.View.extend({
      template: _.template(viewTemplate),
      events: {
        'click .song-item-view': 'onSongItemClicked',
        'click .add-button': 'onAddButtonClicked'
      },
      render: function() {
        var attr;

        attr = _.extend(this.model.attributes, {
          formatDuration: function(duration) {
            var h, ret;

            duration = Math.floor(duration / 1000);
            ret = '';
            h = parseInt(duration / 3600);
            if (h > 0) {
              ret += h + ':' + ('0' + parseInt((duration - 3600 * h) / 60)).slice(-2);
            } else {
              ret += parseInt(duration / 60);
            }
            return ret += ':' + ('0' + (duration % 60)).slice(-2);
          }
        });
        this.$el.html(this.template(attr));
        return this;
      },
      onSongItemClicked: function() {},
      onAddButtonClicked: function(e) {
        Backbone.trigger('PLAYLIST_ITEM_ADD', this.model.clone());
        this.$el.addClass('playlist-added');
        e.stopPropagation();
      }
    });
  });

}).call(this);
