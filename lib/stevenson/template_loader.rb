require 'stevenson/templates/base'
require 'stevenson/templates/git'
require 'yaml'

module Stevenson
  class TemplateLoader
    TEMPLATE_ALIASES_PATH = File.join('..', '..', 'assets', 'template_aliases.yml')

    def self.load(template_name)
      # If a template alias exists with the key template
      if template_aliases[template_name]
        # Load a template and return it
        load_template template_aliases[template_name]
      else
        # Otherwise, return the template string
        load_template template_name
      end
    end

    def self.template_aliases
      # Get the path to the template aliases file
      template_aliases_path = File.join(File.dirname(__FILE__), TEMPLATE_ALIASES_PATH)

      # Load the template aliases
      template_aliases = YAML.load_file template_aliases_path
    end

    def self.load_template(template_string)
      # If the template string is a git repo, create and return a git template
      if template_string =~ /^.*\.git$/
        Templates::GitTemplate.new template_string
      else
        # Otherwise, assume a directory, create and return a base template
        Templates::Base.new template_string
      end
    end
  end
end
