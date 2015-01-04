module Stevenson
  module Input
    autoload :Email, 'stevenson/input/email'
    autoload :Password, 'stevenson/input/password'
    autoload :Select, 'stevenson/input/select'
    autoload :Text, 'stevenson/input/text'
    autoload :Url, 'stevenson/input/url'

    module Base
      attr_reader :options

      def self.included(input)
        input.extend ClassMethods

        Stevenson.inputs[input.input_name] = input
      end

      module ClassMethods
        def input_name
          name.gsub(/^.*::/, '').downcase.to_sym
        end
      end

      def initialize(options, default=nil)
        @options, @default = options, default
      end

      def collect!
        raise NotImplementedError
      end

      def default
        @default ||= options['default'] if options['default']
        @default ||=  ''
      end
    end

    def input_for(options, default_value)
      input_klass = Stevenson.inputs[options['type']]
      raise Configurator::InvalidYAMLException.new "Type \'#{options['type']}\' is not a valid input type." unless input_klass

      input_klass.new(options, default_value)
    end
  end
end
