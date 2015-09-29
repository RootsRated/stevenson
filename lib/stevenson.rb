require 'stevenson/output_filters/jekyll'
require 'stevenson/output_filters/zip'
require 'stevenson/version'

module Stevenson
  autoload :Application, 'stevenson/application'
  autoload :Dotfile, 'stevenson/dotfile'
  autoload :Template, 'stevenson/template'

  def self.dotfile
    @_dotfile ||= Dotfile.new
  end
end
