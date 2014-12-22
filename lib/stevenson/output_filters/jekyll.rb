module Stevenson
  module OutputFilters
    module JekyllFilter
      def output(directory)
        # Jekyll Build the Directory
        Dir.chdir(path) do
          system 'jekyll b'
        end

        # Replace the repository with the compiled directory
        Dir.mktmpdir do |dir|
          FileUtils.cp_r File.join(path, '_site', '.'), dir
          FileUtils.rm_r path
          FileUtils.cp_r dir, path
        end

        # Call the parent method
        super directory
      end
    end
  end
end
