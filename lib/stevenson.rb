require 'stevenson/configurators/yaml_configurator'
require 'stevenson/template_loader'
require 'stevenson/version'

module Stevenson
  autoload :Application, 'stevenson/application'
  autoload :Input, 'stevenson/input'
  autoload :OutputFilter, 'stevenson/output_filter'

  def self.inputs
    @_inputs ||= {}
  end

  def self.output_filters
    @_output_filters ||= {}
  end
end
