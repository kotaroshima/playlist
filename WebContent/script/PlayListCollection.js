/*
 * A Backbone collection with the following functionalities added
 * - moving of models
 * - managing index of current song being played
 */
define(
  ['Underscore', 'Backbone', 'ListCollection'],
  function(_, Backbone, ListCollection){
    return ListCollection.extend({

      initialize: function(){
        ListCollection.prototype.initialize.call(this);

        this.index = -1;

        var self = this;
        pubsub.on("PLAYLIST_ITEM_ADDED", function(model, isPlay){
          var options = null;
          if(isPlay){
            if(self.index === -1){
              // no song is playing, so insert to the front of the play list
              options = { at: 0 };
            }else{
              // currently some song is playing, so insert to after the currently playing song
              options = { at: self.index+1 };
            }
          }
          self.add(model, options);
          if(options){
            self.setIndex(options.at);
          }
        });

        // if current item gets removed, update index
        pubsub.on("PLAYLIST_ITEM_REMOVED", function(model){
          var index = self.indexOf(model);
          if(index < self.index){
            self.setIndex(self.index-1);
          }
        });

        pubsub.on("PLAYLIST_ITEM_SET_INDEX", function(model){
          self.setIndex(self.indexOf(model));
        });
      },

      /*
       * Returns an index within models for a given model
       */
      indexOf: function(model){
        var urls = _.map(this.models, function(m){
          return m.get('uri');
        });
        return _.indexOf(urls, model.get('uri'));
      },

      setIndex: function(index){
        this.index = index;
        pubsub.trigger("PLAYLIST_INDEX_UPDATED", index);
      },

      /*
       * Move model to a new index
       */
      move: function(origIndex, newIndex){
        var model = this.at(origIndex);
        this.remove(model);
        this.add(model, { at: newIndex });
      },

      /*
       * Increments currently playing index, and returns model corresponding to new index
       */
      next: function(){
        if(this.index < this.length-1){
          this.setIndex(this.index+1);
          return this.at(this.index);
        }else{
          this.setIndex(-1);
          return null;
        }
      },
    });
  }
);