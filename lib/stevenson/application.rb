require 'thor'

module Stevenson
  class Application < Thor
    desc 'new PROJECT_NAME CONFIG_PATH', 'generates a Jekyll at PROJECT_NAME with a config file at CONFIG_PATH'

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

    # Output Filter Options
    method_option :output,
                  type: :array,
                  enum: [:zip],
                  aliases: "-o",
                  desc: 'Array of output filters to be applied in order'
    method_option :zip,
                  type: :boolean,
                  aliases: "-z",
                  desc: 'Zip compresses the output directory'

    def new(output_directory, config_path)
      # Load the template using the template loader
      template = Stevenson::Template.load(options[:template], options)

      # Place yml files
      template.place_config(config_path)
      template.place_files(options[:data], '_data') if options[:data]

      # Run output filters, in order, against the template
      puts Stevenson::OutputFilter.generate!(template, options)

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
