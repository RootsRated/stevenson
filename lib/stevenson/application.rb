require 'thor'

module Stevenson
  class Application < Thor
    desc 'new PROJECT_NAME', 'generates a Jekyll at PROJECT_NAME'

    method_option :template,
                  aliases: '-t',
                  default: 'hyde-base',
                  desc: 'The template to use'

    # Template Options
    method_option :branch,
                  aliases: '-b',
                  desc: 'The git branch you would like to use from your template'
    method_option :subdirectory,
                  aliases: '-s',
                  desc: 'The subdirectory to use from the template, if any'

    # Data Options
    method_option :data,
                  aliases: "-d",
                  desc: 'The path to related data yml files'

    # Output Options
    method_option :output,
                  type: :array,
                  aliases: "-o",
                  desc: 'Array of output filters to be applied in order'
    method_option :zip,
                  type: :boolean,
                  aliases: "-z",
                  desc: 'Zip compresses the output directory'

    def new(output_directory)
      # Load the template using the template loader
      template = Stevenson::Template.load(options[:template], options)

      # Place yml files
      template.place_data(options[:data]) if options[:data]

      # Run output filters, in order, against the template
      outputs = [:jekyll]
      outputs.concat options[:output] if options[:output]
      outputs << :zip if options[:zip]
      outputs.each do |filter_type|
        template.extend(Stevenson::OutputFilter.filter_for(filter_type))
      end

      # Save the repo to the output directory
      template.output output_directory

    rescue StandardError => e
      say e.message
    ensure
      template.close
    end

    desc 'generate_dotfile', 'Generates a Stevenson configuration dotfile'
    def generate_dotfile
      Dotfile.install
      puts "Generated dotfile at #{Dotfile.path}"
    end
  end
end
