module Stevenson
  module OutputFilter
    autoload :Jekyll, 'stevenson/output_filter/jekyll'
    autoload :Zip, 'stevenson/output_filter/zip'

    module Base
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
    end
  end
end
