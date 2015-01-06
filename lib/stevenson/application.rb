require 'thor'

module Stevenson
  class Application < Thor
    desc 'stevenson new PROJECT_NAME', 'generates a Jekyll at PROJECT_NAME'

    method_option :branch,
                  aliases: '-b',
                  desc: 'The git branch you would like to use from your template'
    method_option :jekyll,
                  type: :boolean,
                  aliases: '-j',
                  desc: 'Jekyll compiles the output directory'
    method_option :subdirectory,
                  aliases: '-s',
                  desc: 'The subdirectory to use from the template, if any'
    method_option :template,
                  aliases: '-t',
                  default: 'hyde-base',
                  desc: 'The template repository to use'
    method_option :zip,
                  type: :boolean,
                  aliases: "-z",
                  desc: 'Zip compresses the output directory'

    def new(output_directory)
      # Load the template using the template loader
      template = Stevenson::TemplateLoader.load options[:template]

      # If a branch is provided, switch to that branch
      template.switch_branch options[:branch] if options[:branch]

      # If a subdirectory is provided, switch to that directory
      template.select_subdirectory options[:subdirectory] if options[:subdirectory]

      # Configure the template
      configurator = Stevenson::Configurator::YAMLConfigurator.new template.path
      configurator.configure

      # If the jekyll flag is set, compile the template output
      template.extend(Stevenson::OutputFilters::JekyllFilter) if options[:jekyll]

      # If the zip flag is set, zip up the template output
      template.extend(Stevenson::OutputFilters::ZipFilter) if options[:zip]

      # Save the repo to the output directory
      template.output output_directory

    rescue Templates::InvalidTemplateException => e
      say e.message
    end
  end
end