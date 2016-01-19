require 'cocaine'

module Stevenson
  module OutputFilter
    class Jekyll < Base

      def output
        File.join(directory, '_site').tap do |output_directory|
          # Jekyll Build the Directory
          command.run(
            source: directory,
            destination: output_directory
          )
        end
      end

      private

      def command
        Cocaine::CommandLine.new("jekyll", "build --source :source --destination :destination")
      end
    end
  end
end
