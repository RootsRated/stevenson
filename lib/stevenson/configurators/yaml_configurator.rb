require 'highline/import'
require 'yaml'

module Stevenson
  module Configurator
    class YAMLConfigurator
      def initialize(config_path)
        # Save the config path for later use
        @config_path = config_path

        # Load config options from the template
        @options = load_options
        @config = load_config

        # If no config is provided, set it to an empty hash
        @config = {} unless @config
      end

      def configure
        # If there are any options, for each option, ask the user for input
        if @options
          @options.each do |key, value|
            @config[key] = ask_question value, @config[key]
          end
        end
  
        # Save the updated config back to the directory
        File.open("#{@config_path}/_config.yml", 'w') do |f|
          f.write @config.to_yaml
        end
      end

      private

      def load_options
        # If a _stevenson.yml file is present, load it
        if File.file? "#{@config_path}/_stevenson.yml"
          YAML.load_file "#{@config_path}/_stevenson.yml"
        else
          # Otherwise, return false
          false
        end
      end
  
      def load_config
        # If a _config.yml file is present, load it
        if File.file? "#{@config_path}/_config.yml"
          YAML.load_file "#{@config_path}/_config.yml"
        else
          # Otherwise, return false
          false
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
end
