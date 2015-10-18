module Helm
  class App
    attr_reader :namespace, :app_directory

    def initialize(namespace='App', app_directory=nil)
      @namespace = namespace
      @app_directory = app_directory || default_app_directory
    end

    def generate
      generate_app
      generate_router
    end

    private

    def generate_app
      path = "#{app_directory}/app.js"
      blaze_path(path)
      File.open(path, 'w') do |f|
        f.write <<-JS
#{namespace} = Helm.App.extend({
});
        JS
      end
    end

    def generate_router
      path = "#{app_directory}/router.js"
      blaze_path(path)
      File.open(path, 'w') do |f|
        f.write <<-JS
#{namespace}.Router = Helm.Router.extend({
  routes: {
    '': 'homeRoute',
    'my/:thing': 'somethingGreat',
    '*path':  'catchAll'
  },

  homeRoute: function() {
    this.page([
      new #{namespace}.Views.Home()
    ]);
  }

  /* etc, more methods for each path */
});
        JS
      end
    end

    def default_app_directory
      File.expand_path("../../../assets/javascripts/app", __FILE__)
    end

    def blaze_path(path)
      FileUtils.mkdir_p(File.dirname(path))
    end
  end
end
