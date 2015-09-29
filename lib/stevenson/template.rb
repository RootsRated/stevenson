module Stevenson
  module Template
    autoload :Git, 'stevenson/templates/git'
    autoload :Local, 'stevenson/templates/local'

    autoload :Loader, 'stevenson/template/loader'

    def self.load(template, options)
    end

    class Base
      attr_reader :name, :options

      def initialize(name, options = {})
        @name, @options = name, options
      end
    end

    class InvalidTemplateException < StandardError; end
  end
end
