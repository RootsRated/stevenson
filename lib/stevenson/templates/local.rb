module Stevenson
  module Template
    class Local < Base
      attr_reader :template_path, :options

      def initialize(template_path, options)
        @template_path, @options = template_path, options
      end

      def local_directory
        raise InvalidTemplateException.new("The given path is not a directory '#{template_path}'") unless File.directory?(template_path)

        @_local_directory ||= Dir.mktmpdir.tap do |dir|
          directories = [template_path, options[:subdirectory], '.'].compact

          FileUtils.cp_r File.join(*directories), dir
        end
      end
    end
  end
end
