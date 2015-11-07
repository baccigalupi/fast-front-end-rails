var App = Helm.App.extend({
  init: function() {
    Helm.RequestMiddleware.AuthToken.token = $('meta[name="csrf-token"]').attr('content');
  }
});
