require 'git'

module Stevenson
  module Template
    class Git < Local
      attr_reader :template_url, :options

      def initialize(template_url, options)
        @template_url, @options = template_url, options
      end

      def local_directory
        @_local_directory ||= begin
          @template_path ||= Dir.mktmpdir.tap do |dir|
            # Clone the repo to a temporary directory for later use
            ::Git.clone(template_url, dir).tap do |repo|
              # Switch_branch if set
              repo.checkout(options[:branch]) if options.has_key?(:branch)
            end
          end

          super
        end
      rescue ::Git::GitExecuteError
        # If the given repo URL is not valid, raise an exception
        raise InvalidTemplateException.new('Failed to clone the repository and/or branch')
      end

      def close
        FileUtils.rm_rf template_path if template_path
        super
      end
    end
  end
end
