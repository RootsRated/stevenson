require 'rugged'
require 'tmpdir'

module Stevenson
  module Template
    class GitTemplate
      def initialize(template_url)
        # Clone the repo to a temporary directory for later use
        @tmpdir = Dir.mktmpdir
        @repo = Rugged::Repository.clone_at template_url, "#{@tmpdir}/repo"
      rescue Rugged::NetworkError => e
        # If the given URL is not valid, set the repo to false
        @repo = false
      end

      def is_valid?
        # Return whether or not the repo was successfully cloned
        @repo != false
      end

      def path
        # Return the path to the repo
        @repo.workdir
      end

      def cleanup
        # Cleanup the temporary directory
        FileUtils.remove_entry_secure @tmpdir
      end
    end
  end
end
