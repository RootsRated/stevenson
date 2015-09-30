require 'delegate'
require 'hashie/mash'
require 'yaml'

module Stevenson
  class Dotfile < SimpleDelegator

    TEMPLATE_PATH = File.join(File.dirname(__FILE__), '..', '..', 'assets', 'stevenson_dotfile.yml')
    DOTFILE_PATH = File.join(Dir.home, ".stevenson")

    class << self
      def install
        FileUtils.copy TEMPLATE_PATH, DOTFILE_PATH
      end

      def path
        DOTFILE_PATH
      end
    end

    def initialize
      dotfile_path = File.exist?(self.class.path) ? self.class.path : TEMPLATE_PATH
      super Hashie::Mash.new YAML.load_file(dotfile_path)
    end
  end
end
