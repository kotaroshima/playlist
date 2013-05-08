// Generated by CoffeeScript 1.6.2
(function() {
  define(['jQuery', 'Underscore'], function($, _) {
    return {
      setup: function() {
        this._currentIndex = -1;
        this.on('remove', this.onRemoved, this);
      },
      indexOf: function(model) {
        var urls;

        urls = _.map(this.models, function(m) {
          return m.get('uri');
        });
        return _.indexOf(urls, model.get('uri'));
      },
      setCurrentModel: function(model) {
        var index;

        index = this.indexOf(model);
        this.setCurrentIndex(index);
      },
      setCurrentIndex: function(index) {
        this._currentIndex = index;
      },
      insertAfterCurrent: function(model) {
        var index;

        index = this._currentIndex === -1 ? 0 : this._currentIndex + 1;
        this.add(model, {
          at: index
        });
        this.setCurrentIndex(index);
      },
      next: function() {
        if (this._currentIndex < this.length - 1) {
          this.setCurrentIndex(this._currentIndex + 1);
          return this.at(this._currentIndex);
        } else {
          this.setCurrentIndex(-1);
          return null;
        }
      },
      onRemoved: function(model) {
        var index;

        index = this.indexOf(model);
        if (index < this._currentIndex) {
          this.setCurrentIndex(this._currentIndex - 1);
        }
      },
      cleanup: function() {
        this.off('remove', this.onRemoved, this);
      }
    };
  });

}).call(this);