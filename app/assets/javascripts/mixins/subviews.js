Helm.Mixins.Subviews = {
  renderEach: function (subviews) {
    this._subviews = subviews;

    _.each(subviews, function (view) {
      if(view) {
        view.parent = view.parent || this.defaultParent();
        view.repository = view.repository || this.repository;
        view.templates =  view.templates  || this.templates;
        view.viewModelClasses = view.viewModelClasses || this.viewModelClasses;
        view.render();
      }
    }.bind(this));
  },

  unpackApp: function(app) {
    app || (app = {});
    this.repository = app.repository;
    this.templates =  app.Templates;
    this.viewModelClasses = app.ViewModels;
  },

  remove: function() {
    this.removeSelf();

    _.each(this._subviews || [], function(view) {
      view.remove();
    });
  },

  removeSelf: function() {
    // override me!
  },

  defaultParent: function() {
    return this;
  },

  subviews: function() { return []; },
  afterRender: function() {}
};
