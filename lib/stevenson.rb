require 'stevenson/configurators/yaml_configurator'
require 'stevenson/output_filters/jekyll'
require 'stevenson/output_filters/zip'
require 'stevenson/template_loader'
require 'stevenson/version'

module Stevenson
  autoload :Application, 'stevenson/application'
  autoload :Input, 'stevenson/input'

  def self.inputs
    @_inputs ||= {}
  end
end
