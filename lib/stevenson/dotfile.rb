require 'hashie/mash'
require 'yaml'

module Stevenson
  class Dotfile < SimpleDelegator

    TEMPLATE_PATH = File.join('..', '..', 'assets', 'stevenson_dotfile.yml')
    DOTFILE_PATH = File.join(Dir.home, ".stevenson")

    class << self
      def install
        FileUtils.copy File.join(File.dirname(__FILE__), TEMPLATE_PATH), DOTFILE_PATH
      end

      def path
        DOTFILE_PATH
      end
    end

    def initialize
      if File.exist?(self.class.path)
        super Hashie::Mash.new YAML.load_file(self.class.path)
      end
    end
  end
end
