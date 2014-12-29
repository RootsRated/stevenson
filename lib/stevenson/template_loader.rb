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
      elsif template_name =~ /^.*\.git$/
        # If the given string is a git url, load the git template and return it
        Templates::GitTemplate.new template_name
      else
        # Otherwise, return a new template using the name as a path
        Templates::Base.new template_name
      end
    end

    def self.template_aliases
      # Get the path to the template aliases file
      template_aliases_path = File.join(File.dirname(__FILE__), TEMPLATE_ALIASES_PATH)

      # Load the template aliases
      template_aliases = YAML.load_file template_aliases_path
    end

    def self.load_template(template_options)
      # If the template options contain a git url, load the git template and return it
      if template_options['git']
        template = Templates::GitTemplate.new template_options['git']
        template.switch_branch template_options['branch'] if template_options['branch']
        template
      else
        # Otherwise, return false
        false
      end
    end
  end
end
