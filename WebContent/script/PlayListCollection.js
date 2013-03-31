// Generated by CoffeeScript 1.4.0
(function() {

  define(['Underscore', 'Backpack', 'SoundPlayer'], function(_, Backpack, player) {
    return Backbone.Collection.extend({
      initialize: function() {
        var _this = this;
        Backbone.Collection.prototype.initialize.call(this);
        this.index = -1;
        Backbone.on("PLAYLIST_ITEM_ADDED", function(model, isPlay) {
          var options;
          options = null;
          if (isPlay) {
            if (_this.index === -1) {
              options = {
                at: 0
              };
            } else {
              options = {
                at: _this.index + 1
              };
            }
          }
          _this.add(model, options);
          if (options) {
            _this.setIndex(options.at);
          }
        });
        Backbone.on("PLAYLIST_ITEM_REMOVED", function(model) {
          var index;
          index = _this.indexOf(model);
          if (index < _this.index) {
            _this.setIndex(_this.index - 1);
          }
        });
        return Backbone.on("PLAYLIST_ITEM_SET_INDEX", function(model) {
          _this.setCurrentModel(model);
        });
      },
      indexOf: function(model) {
        var urls;
        urls = _.map(this.models, function(m) {
          return m.get('uri');
        });
        _.indexOf(urls, model.get('uri'));
      },
      setCurrentModel: function(model) {
        var index;
        index = this.indexOf(model);
        this.setIndex(index);
      },
      setIndex: function(index) {
        this.index = index;
        Backbone.trigger("PLAYLIST_INDEX_UPDATED", index);
      },
      next: function() {
        if (this.index < this.length - 1) {
          this.setIndex(this.index + 1);
          return this.at(this.index);
        } else {
          this.setIndex(-1);
          return null;
        }
      },
      onSongFinished: function() {
        var model;
        model = this.next();
        if (model) {
          player.play(model);
        }
      }
    });
  });

}).call(this);
