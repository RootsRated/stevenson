require 'git'

module Stevenson
  module Template
    class Git < Base
      attr_reader :template_url, :options

      def initialize(template_url, options)
        @template_url, @options = template_url, options
      end

      def local_directory
        @_local_directory ||= Dir.mktmpdir.tap do |dir|
          # Clone the repo to a temporary directory for later use
          ::Git.clone(template_url, dir).tap do |repo|
            # Switch_branch if set
            repo.checkout(options[:branch]) if options.has_key?(:branch)
          end
        end
      rescue ::Git::GitExecuteError
        # If the given repo URL is not valid, raise an exception
        raise InvalidTemplateException.new('Failed to clone the repository')
      end
    end
  end
end
