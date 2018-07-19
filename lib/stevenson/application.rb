require 'thor'

module Stevenson
  class Application < Thor
    desc 'new PROJECT_NAME CONFIG_PATH', 'generates a Jekyll at PROJECT_NAME with a config file at CONFIG_PATH'

    method_option :template,
                  aliases: '-t',
                  default: 'hyde-base',
                  desc: 'The template to use'

    method_option :private_template,
                  type: :array,
                  desc: 'Private git template url and credentials. Takes priority over normal template option.'

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
                  aliases: "-z",
                  desc: 'Zip compresses the output directory'

    # Deploy Options
    method_option :s3,
                  type: :array,
                  banner: 'bucket key access_key access_secret',
                  desc: 'The s3 information necessary for deploying to S3'

    def new(output_directory, config_path)
      if options[:private_template]
        template_url, git_username, git_password = options[:private_template]
        git_username ||= ENV["GITHUB_SERVICE_ACCOUNT_USERNAME"]
        git_password ||= ENV["GITHUB_SERVICE_ACCOUNT_PASSWORD"]
        template = template_url.gsub("github", "#{git_username}:#{git_password}@github")
      else
        template = options[:template]
      end

      # Load the template using the template loader
      template = Stevenson::Template.load(template, options)

      # Place yml files
      template.place_config(config_path)
      template.place_files(options[:data], '_data') if options[:data]

      # Run output filters, in order, against the template
      directory = Stevenson::OutputFilter.generate!(template, options)

      # Run deployers against filtered template directory
      Stevenson::Deployer.deploy(directory, options)

    rescue Stevenson::Error => e
      say e.message
    ensure
      template.close if template
    end

    desc 'generate_dotfile', 'Generates a Stevenson configuration dotfile'
    def generate_dotfile
      Dotfile.install
      puts "Generated dotfile at #{Dotfile.path}"
    end
  end
end
