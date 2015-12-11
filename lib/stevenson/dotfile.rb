require 'delegate'
require 'hashie/mash'
require 'yaml'

module Stevenson
  class Dotfile < SimpleDelegator

    TEMPLATE_PATH = File.join(File.dirname(__FILE__), '..', '..', 'assets', 'stevenson_dotfile.yml')
    DOTFILE_FILENAME = ".stevenson"

    class << self
      def install
        FileUtils.copy TEMPLATE_PATH, path
      end

      def path
        File.join(user_path, DOTFILE_FILENAME)
      end

      private

      def user_path
        Dir.home rescue ENV.fetch('HOME', "/")
      end
    end

    def initialize
      dotfile_path = File.exist?(self.class.path) ? self.class.path : TEMPLATE_PATH
      super Hashie::Mash.new YAML.load_file(dotfile_path)
    end
  end
end
