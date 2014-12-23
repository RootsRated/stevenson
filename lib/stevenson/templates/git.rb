require 'git'
require 'stevenson/templates/base'

module Stevenson
  module Templates
    class GitTemplate < Base
      def initialize(template_url)
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

      def switch_branch(branch)
        repo = Git::Base.open(path)
        repo.checkout(branch)
      end
    end
  end
end
