module Helm
  class RawTemplates
    attr_reader :mustache_directory

    def initialize(mustache_directory=nil)
      @mustache_directory = mustache_directory || default_mustache_directory
    end

    def as_json
      Dir.glob("#{mustache_directory}/**/*.mustache").inject({}) do |collection, path|
        collection[key(path)] = value(path)
        collection
      end
    end

    def to_json(*args)
      as_json.to_json
    end

    private

    def key(path)
      path
        .sub(mustache_directory, '')
        .sub(/\.mustache$/, '')
        .sub(/^\//, '')
    end

    def value(path)
      File.read(path)
    end

    def default_mustache_directory
      File.expand_path("../../../assets/javascripts/app/templates", __FILE__)
    end
  end
end
