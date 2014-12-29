require 'stevenson/templates/invalid_template_exception'

module Stevenson
  module Templates
    class Base
      def initialize(path)
        if !File.directory?(path)
          # If the given path is not a directory, raise an invalid template exception
          raise InvalidTemplateException.new('The given path is not a directory')
        else
          # Otherwise, copy the template to a temporary directory to work with
          @path = Dir.mktmpdir
          FileUtils.cp_r File.join(path, '.'), @path
        end
      end
  
      def path
        # Return the path to the repo
        @path
      end

      def select_subdirectory(directory)
        # Create a new temporary directory to work from
        new_path = Dir.mktmpdir

        # Copy files from the subdirectory to the new temp dir
        FileUtils.cp_r File.join(@path, directory, '.'), new_path

        # Remove the old temporary directory
        FileUtils.remove_entry_secure @path

        # Set the path to the new path
        @path = new_path
      end
  
      def output(directory)
        # Copy the configured template to the output_directory
        FileUtils.copy_entry @path, directory
  
        # Cleanup the temporary directory
        FileUtils.remove_entry_secure @path
      end
    end
  end
end
