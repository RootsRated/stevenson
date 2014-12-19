require 'stevenson/configurators/yaml_configurator'
require 'stevenson/templates/git_template'
require 'stevenson/version'
require 'thor'

module Stevenson

  class Application < Thor
    desc 'stevenson new PROJECT_NAME', 'generates a Jekyll at PROJECT_NAME'

    method_option :template,
                  aliases: '-t',
                  default: 'https://github.com/RootsRated/hyde.git',
                  desc: 'The template repository to use'

    def new(output_directory)
      # Load the GitTemplate using the template option
      template = Stevenson::Template::GitTemplate.new options[:template]

      # If the template provided is valid, configure and save the template
      if template.is_valid?
        # Configure the template
        configurator = Stevenson::Configurator::YAMLConfigurator.new template.path
        configurator.configure
  
        # Copy the tempory directory to the output_directory
        FileUtils.copy_entry template.path, output_directory
      else
        say 'No git repository could be found at the provided URL.'
      end

      # Cleanup the template before exiting
      template.cleanup
    end
  end
end
