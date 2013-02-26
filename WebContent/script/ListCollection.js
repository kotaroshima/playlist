define(
  ['Underscore', 'Backbone', 'ListModel'],
  function(_, Backbone, ListModel){
    return Backbone.Collection.extend({
      model: ListModel,

      initialize: function(){
        Backbone.Collection.prototype.initialize.call(this);

        this.index = -1;

        // if current item gets removed, update index
        var self = this;
        pubsub.on("PLAY_LIST_ITEM_REMOVED", function(model){
          var urls = _.map(self.models, function(m){
            return m.get('uri');
          });
          var index = _.indexOf(urls, model.get('uri'));
          if(self.index == index){
            if(!self.next()){
              this.index = -1;
            }
          }
        });
      },

      move: function(origIndex, newIndex){
        var model = this.at(origIndex);
        this.remove(model);
        this.add(model, { at: newIndex });
      },

      setIndex: function(index){
        if(0 <= index && index < this.length){
          this.index = index;
        }
      },

      next: function(){
        if(this.index < this.length-1){
          this.index++;
          return this.at(this.index);
        }
      },
    });
  }
);