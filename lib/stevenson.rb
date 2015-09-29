require 'stevenson/configurators/yaml_configurator'
require 'stevenson/output_filters/jekyll'
require 'stevenson/output_filters/zip'
require 'stevenson/template_loader'
require 'stevenson/version'

module Stevenson
  autoload :Application, 'stevenson/application'
  autoload :Dotfile, 'stevenson/dotfile'

  def self.dotfile
    @_dotfile ||= Dotfile.new
  end
end
