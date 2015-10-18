Helm.History = Helm.BaseClass.extend({
  initialize: function() {
    this.list = [];
    Backbone.history.start();

    this.init(arguments);
  },

  listenTo: function(router) {
    router.on('route:start', this.push, this);
  },

  push: function(fragment, args) {
    this.list.push(fragment);
  },

  pop: function() {
    return this.list.pop();
  },

  init: function() {}
});
