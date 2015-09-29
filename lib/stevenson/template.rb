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

      def place_config(config_file)
        place_files(config_file, 'config.yml')
      end

      def place_files(files, directory)
        action = File.directory?(files) ? :cp_r : :cp
        FileUtils.send(action, files, File.join(local_directory, directory))
      end

      def close
        FileUtils.rm_rf local_directory if local_directory
      end
    end

    class InvalidTemplateException < StandardError; end
  end
end
