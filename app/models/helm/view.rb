module Helm
  class View
    attr_reader :view_path, :app_directory, :app_namespace

    def initialize(view_path, app_directory=nil, app_namespace='App')
      @view_path = view_path
      @app_directory = app_directory || default_app_directory
      @app_namespace = app_namespace
    end

    def generate
      generate_template
      generate_view_model
      generate_view
    end

    private

    def generate_template
      path = "#{app_directory}/templates/#{view_path}.mustache"
      blaze_path(path)
      File.open(path, 'w') do |f|
        f.write <<-HTML
<h1>Create some content: #{path}</h1>
        HTML
      end
    end

    def generate_view_model
      path = "#{app_directory}/view_models/#{view_path}.js"
      blaze_path(path)
      File.open(path, 'w') do |f|
        f.write <<-JS
#{app_namespace}.ViewModels.#{js_class_name} = Helm.ViewModel.extend({
  include: [] // add method names here
  // then add the matching method here, the result is injected into the generated json view model
});
        JS
      end
    end

    def generate_view
      path = "#{app_directory}/views/#{view_path}.js"
      blaze_path(path)
      File.open(path, 'w') do |f|
        f.write <<-JS
#{app_namespace}.Views.#{js_class_name} = Helm.View.extend({
  config: {
    viewModel: '#{js_class_name}',
    template: '#{view_path}',
    events: {
      // add your usual backbone event hash thingies
    }
    // parentSelector: '.#{view_path.gsub('/', '-')}-container'
  },

  className: '#{view_path.gsub('/', '-')}'

  /*
  *  Add subviews that automatically render. They should have a parent selector that they can grab on to in this view
  *  otherwise they end up appended. You can prepend too, but keep it simple probably!
  *
  subviews: function() {
    return [
      new App.Views.MyGreatView({model: model}) // etc
    ];
  }
  *
  *  Maybe you need some partial templates?
  partials: function() {
    return {
      foo: this.templates['something/fooey']
    };
  }
  */
});
        JS

      end
    end

    def js_class_name
      view_path.split('/').map(&:classify).join('.')
    end

    def default_app_directory
      File.expand_path("../../../assets/javascripts/app", __FILE__)
    end

    def blaze_path(path)
      FileUtils.mkdir_p(File.dirname(path))
    end
  end
end
