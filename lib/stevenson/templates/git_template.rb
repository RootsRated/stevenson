require 'git'
require 'tmpdir'
require 'yaml'

module Stevenson
  module Template
    class GitTemplate
      TEMPLATE_ALIASES_PATH = File.join('..', '..', '..', 'assets', 'template_aliases.yml')

      def initialize(template)
        # Fetch the template_url from the template
        template_url = load_template_url template

        # Clone the repo to a temporary directory for later use
        @tmpdir = Dir.mktmpdir
        @repo = Git.clone template_url, File.join(@tmpdir, 'repo')
      rescue Git::GitExecuteError => e
        # If the given URL is not valid, set the repo to false
        @repo = false
      end

      def repository
        # Return the repo object
        @repo
      end

      def is_valid?
        # Return whether or not the repo was successfully cloned
        @repo != false
      end

      def path
        # Return the path to the repo
        @repo.dir.to_s
      end

      def cleanup
        # Cleanup the temporary directory
        FileUtils.remove_entry_secure @tmpdir
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
