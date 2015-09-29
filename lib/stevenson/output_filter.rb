module Stevenson
  module OutputFilter
    autoload :Jekyll, 'stevenson/output_filter/jekyll'
    autoload :Zip, 'stevenson/output_filter/zip'

    autoload :Generator, 'stevenson/output_filter/generator'

    class Base
      attr_reader :directory

      def self.included(filter)
        filter.extend ClassMethods

        Stevenson.output_filters[filter.filter_name] = filter
      end

      module ClassMethods
        def filter_name
          name.gsub(/^.*::/, '').downcase.to_sym
        end
      end

      def initialize(directory)
        @directory = directory
      end

      def output
        raise NotImplementedError
      end
    end

    def self.generate!(template, options)
      Generator.new(options).generate!(template)
    end

    def self.filter_for(type)
      Stevenson.output_filters[type] || const_get(type.to_s.capitalize)
    rescue NameError => e
      raise NameError.new "Type '#{type}' is not a valid output type.", e
    end
  end
end
