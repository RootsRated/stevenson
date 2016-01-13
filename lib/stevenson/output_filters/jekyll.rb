require 'cocaine'

module Stevenson
  module OutputFilter
    class Jekyll < Base

      def output
        # Jekyll Build the Directory
        command.run(source: directory)

        # Return output directory
        File.join(directory, '_site')
      end

      private

      def command
        Cocaine::CommandLine.new("jekyll", "build --source :source")
      end
    end
  end
end
