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

    def self.input_for(options)
      input_klass = input_klass_for(options['type'])
      input_klass.new(options)
    end

    private

    def self.input_klass_for(type)
      Stevenson.inputs[type] || const_get(type.to_s.capitalize)
    rescue NameError => e
      raise NameError.new "Type '#{type}' is not a valid input type.", e
    end
  end
end
