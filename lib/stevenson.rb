require 'active_support/all'
require 'highline/import'
require 'stevenson/template_loaders/git_loader'
require 'stevenson/version'
require 'thor'
require 'yaml'

module Stevenson

  class Application < Thor
    desc 'stevenson new PROJECT_NAME', 'generates a Jekyll at PROJECT_NAME'

    method_option :template,
                  aliases: '-t',
                  default: 'https://github.com/RootsRated/stevenson-base-template.git',
                  desc: 'The template repository to use'

    def new(output_directory)
      # Load the Template to Use
      template_directory = load_template

      # Load config options from the directory
      options = load_options template_directory
      config = load_config template_directory

      # If there are any options, for each option, ask the user for input
      if options
        options.each do |key, value|
          config[key] = ask_question value, config[key]
        end
      end

      # Save the updated config back to the directory
      File.open("#{template_directory}/_config.yml", 'w') do |f|
        f.write config.to_yaml
      end

      # Copy the tempory directory to the output_directory and cleanup
      FileUtils.copy_entry template_directory, output_directory
      FileUtils.remove_entry_secure template_directory
    end

    private

    def load_template
      # Use the GitLoader to clone the template repo to a temporary directory
      loader = Stevenson::TemplateLoaders::GitLoader.new options[:template]
      loader.load
    end

    def load_options(directory_name)
      # If a _stevenson.yml file is present, load it
      if File.file? "#{directory_name}/_stevenson.yml"
        YAML.load_file "#{directory_name}/_stevenson.yml"
      else
        # Otherwise, output an error and exit
        say 'No _stevenson.yml file could be found in this template.'
        exit
      end
    end

    def load_config(directory_name)
      # If a _config.yml file is present, load it
      if File.file? "#{directory_name}/_config.yml"
        YAML.load_file "#{directory_name}/_config.yml"
      else
        # Otherwise, output an error and exit
        say 'No _config.yml file could be found in this template.'
        exit
      end
    end

    def ask_question(options, default_value)
      # Load the question text and highline options hash
      question = options['question']
      options.delete 'question'

      # Ask the user the question and apply all options
      answer = ask(question) do |q|
        q.default = default_value if default_value
        q.echo = false if options['secret']
        q.validate = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i  if options['email']
        q.validate = /https?:\/\/[\S]+/  if options['url']
        q.limit = options['limit'] if options['limit']
      end

      # Return the user's answer
      answer.to_s
    end
  end
end
