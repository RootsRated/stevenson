module Stevenson
  module Template
    class Loader
      attr_reader :template_name, :options

      def initialize(template_name, options)
        @template_name, @options = template_name, options
      end

      def template
        return Template.load(matching_alias.name, matching_alias.options) if matching_alias?

        template_klass.new template_name, options
      end

      def template_klass
        case template_name
        when /^.*\.git$/
          Template::Git
        else
          Template::Local
        end
      end

      private

      def matching_alias
        Stevenson.dotfile.template_aliases.fetch(template_name, nil)
      end

      def matching_alias?
        !!matching_alias
      end
    end
  end
end
