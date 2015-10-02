require 'stevenson/version'

module Stevenson
  autoload :Application, 'stevenson/application'
  autoload :Deployer, 'stevenson/deployer'
  autoload :Dotfile, 'stevenson/dotfile'
  autoload :Template, 'stevenson/template'
  autoload :OutputFilter, 'stevenson/output_filter'

  def self.deployers
    @_deployers ||= {}
  end

  def self.dotfile
    @_dotfile ||= Dotfile.new
  end

  def self.output_filters
    @_output_filters ||= {}
  end
end
