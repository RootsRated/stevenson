require 'zip'

module Stevenson
  module OutputFilter
    class Zip < Base

      def output
        "#{directory}.zip".tap do |dir|
          # Zip up the output directory
          write directory, dir
        end
      end

      private

      def write(inputDir, outputFile)
        @inputDir = inputDir
        @outputFile = outputFile

        entries = Dir.entries(@inputDir)
        entries.delete(".")
        entries.delete("..")
        io = ::Zip::File.open(@outputFile, ::Zip::File::CREATE)

        writeEntries(entries, "", io)
        io.close()
      end

      def writeEntries(entries, path, io)
        entries.each do |entry|
          zipFilePath = path == "" ? entry : File.join(path, entry)
          diskFilePath = File.join(@inputDir, zipFilePath)
          if File.directory?(diskFilePath)
            io.mkdir(zipFilePath)
            subdir = Dir.entries(diskFilePath); subdir.delete("."); subdir.delete("..")
            writeEntries(subdir, zipFilePath, io)
          else
            io.get_output_stream(zipFilePath) { |f| f.puts(File.open(diskFilePath, "rb").read()) }
          end
        end
      end
    end
  end
end
