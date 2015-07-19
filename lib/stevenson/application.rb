require 'thor'

module Stevenson
  class Application < Thor
    desc 'stevenson new PROJECT_NAME', 'generates a Jekyll at PROJECT_NAME'

    method_option :branch,
                  aliases: '-b',
                  desc: 'The git branch you would like to use from your template'
    method_option :subdirectory,
                  aliases: '-s',
                  desc: 'The subdirectory to use from the template, if any'
    method_option :template,
                  aliases: '-t',
                  default: 'hyde-base',
                  desc: 'The template repository to use'

    method_option :output,
                  type: :array,
                  aliases: "-o",
                  desc: 'Array of output filters to be applied in order'
    method_option :jekyll,
                  type: :boolean,
                  aliases: '-j',
                  desc: 'Jekyll compiles the output directory'
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

      # Run output filters, in order, against the template
      outputs = options[:output] || []
      outputs << :jekyll if options[:jekyll]
      outputs << :zip if options[:zip]
      outputs.each do |filter_type|
        template.extend(Stevenson::OutputFilter.filter_for(filter_type))
      end

      # Save the repo to the output directory
      template.output output_directory

    rescue Templates::InvalidTemplateException => e
      say e.message
    end
  end
end
