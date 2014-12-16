require 'rugged'
require 'tmpdir'

module Stevenson
  module TemplateLoaders
    class GitLoader
      def initialize(template_url)
        # Set the template_url for later use
        @template_url = template_url
      end

      def load
        # Clone the repo to a temporary directory to work with
        dir = Dir.mktmpdir
        Rugged::Repository.clone_at @template_url, "#{dir}/repo"

        # Return the path to the temporary directory
        "#{dir}/repo"
      end
    end
  end
end
