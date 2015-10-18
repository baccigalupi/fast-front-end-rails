Helm.App = Helm.BaseClass.extend(Helm.Mixins.Subviews).extend({
  _init: function($el) {
    this.$el = this.parent = $el;
  },

  start: function() {
    this.manageHistory();
    this.router = new (this.routerClass())(this, this.$el);
    this.repository || (this.repository = this.createRepository());
    this.router.repository = this.repository;
    this.render();
  },

  render: function() {
    this.renderEach(this.subviews());
    this.afterRender();
  },

  manageHistory: function() {
    if (Helm.history) {
      this.history = Helm.history;
    } else {
      this.history = Helm.history = new Helm.History();
    }
  },

  routerClass: function() {
    if (this.constructor.Router) { return this.constructor.Router; }
    throw "No Router class found!";
  },

  createRepository: function() {
    var klass = this.constructor.Repository;
    klass || (klass = this.Repository);
    if (klass) {
      return new klass();
    }
  },
});

Helm.App.extend = function() {
  var klass = Helm.BaseClass.extend.apply(this, arguments);
  klass.Models = {};
  klass.Views = {};
  klass.Templates = {};
  klass.ViewModels = {};
  return klass;
};
