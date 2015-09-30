module Stevenson
  module OutputFilter
    class Generator
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def generate!(template)
        filters.inject(template.local_directory) do |rendered, filter|
          OutputFilter.filter_for(filter).new(rendered).output
        end
      end

      private

      def filters
        @_filters ||= begin
          filters = [:jekyll]
          filters.concat options[:output] if options[:output]
          filters << :zip if options[:zip]
          filters.uniq
        end
      end

    end

  end
end
