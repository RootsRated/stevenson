require 'stevenson/configurators/yaml_configurator'
require 'stevenson/output_filters/jekyll'
require 'stevenson/output_filters/zip_filter'
require 'stevenson/templates/git_template'
require 'stevenson/version'
require 'thor'

module Stevenson

  class Application < Thor
    desc 'stevenson new PROJECT_NAME', 'generates a Jekyll at PROJECT_NAME'

    method_option :jekyll,
                  type: :boolean,
                  aliases: "-j",
                  desc: 'Jekyll compiles the output directory'
    method_option :template,
                  aliases: '-t',
                  default: 'hyde',
                  desc: 'The template repository to use'
    method_option :zip,
                  type: :boolean,
                  aliases: "-z",
                  desc: 'Zip compresses the output directory'

    def new(output_directory)
      # Load the GitTemplate using the template option
      template = Stevenson::Template::GitTemplate.new options[:template]

      # If the template provided is valid, configure and save the template
      if template.is_valid?
        # Configure the template
        configurator = Stevenson::Configurator::YAMLConfigurator.new template.path
        configurator.configure

        # If the jekyll flag is set, compile the template output
        template.extend(Stevenson::OutputFilters::Jekyll) if options[:jekyll]

        # If the zip flag is set, zip up the template output
        template.extend(Stevenson::OutputFilters::Zip) if options[:zip]

        # Save the repo to the output directory
        template.output output_directory
      else
        say 'No git repository could be found at the provided URL.'
      end
    end
  end
end
