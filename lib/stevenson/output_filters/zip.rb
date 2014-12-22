require 'zip'

module Stevenson
  module OutputFilters
    module Zip
      def output(directory)
        # Call the parent method
        super directory

        # Zip up the output directory
        write directory, "#{directory}.zip"
      end

      private

      def write(inputDir, outputFile)
        @inputDir = inputDir
        @outputFile = outputFile

        entries = Dir.entries(@inputDir); entries.delete("."); entries.delete("..")
        io = Zip::File.open(@outputFile, Zip::File::CREATE);
        writeEntries(entries, "", io)
        io.close();
      end

      def writeEntries(entries, path, io)
        entries.each { |e|
          zipFilePath = path == "" ? e : File.join(path, e)
          diskFilePath = File.join(@inputDir, zipFilePath)
          puts "Deflating " + diskFilePath
          if File.directory?(diskFilePath)
            io.mkdir(zipFilePath)
            subdir =Dir.entries(diskFilePath); subdir.delete("."); subdir.delete("..")
            riteEntries(subdir, zipFilePath, io)
          else
            io.get_output_stream(zipFilePath) { |f| f.puts(File.open(diskFilePath, "rb").read())}
          end
        }
      end
    end
  end
end
