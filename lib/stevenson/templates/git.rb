require 'git'
require 'stevenson/templates/base'
require 'tmpdir'
require 'yaml'

module Stevenson
  module Templates
    class GitTemplate < Base
      TEMPLATE_ALIASES_PATH = File.join('..', '..', '..', 'assets', 'template_aliases.yml')

      def initialize(template)
        # Fetch the template_url from the template
        template_url = load_template_url template

        # Create a temporary directory to clone the repo at
        Dir.mktmpdir do |dir|
          # Clone the repo to a temporary directory for later use
          Git.clone template_url, File.join(dir, 'repo')

          # Call the super, thereby assigning the @path
          super File.join(dir, 'repo')
        end
      rescue Git::GitExecuteError => e
        # If the given URL is not valid, raise an exception and cleanup
        raise InvalidTemplateException.new('Failed to clone the repository')
      end

      private

      def load_template_url(template)
        # Get the path to the template aliases file
        template_aliases_path = File.join(File.dirname(__FILE__), TEMPLATE_ALIASES_PATH)

        # Load the template aliases
        template_aliases = YAML.load_file template_aliases_path

        # If a template alias exists with the key template
        if template_aliases[template]
          # Returns its URL
          template_aliases[template]
        else
          # Otherwise, return the template string
          template
        end
      end
    end
  end
end
