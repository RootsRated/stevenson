require 'stevenson/version'

module Stevenson
  autoload :Application, 'stevenson/application'
  autoload :Dotfile, 'stevenson/dotfile'
  autoload :Template, 'stevenson/template'
  autoload :OutputFilter, 'stevenson/output_filter'

  def self.dotfile
    @_dotfile ||= Dotfile.new
  end

  def self.output_filters
    @_output_filters ||= {}
  end
end
