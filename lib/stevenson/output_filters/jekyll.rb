module Stevenson
  module OutputFilter
    class Jekyll < Base

      def output
        # Jekyll Build the Directory
        Dir.chdir(directory) do
          `jekyll b`
        end

        File.join(directory, '_site')
      end
    end
  end
end
