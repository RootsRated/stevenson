module Stevenson
  module Template
    autoload :Git, 'stevenson/templates/git'
    autoload :Local, 'stevenson/templates/local'

    autoload :Loader, 'stevenson/template/loader'

    def self.load(template, options)
      Loader.new(template, options).template
    end

    class Base
      attr_reader :name, :options

      def initialize(name, options = {})
        @name, @options = name, options
      end

      def place_data(data)
        action = File.directory?(data) ? :cp_r : :cp
        FileUtils.send(action, data, local_data_directory)
      end

      def local_data_directory
        File.join(local_directory, '_posts')
      end

      def close
        FileUtils.rm_rf local_directory if local_directory
      end
    end

    class InvalidTemplateException < StandardError; end
  end
end
