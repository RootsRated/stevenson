require 'highline/import'
require 'yaml'

module Stevenson
  module Configurator
    class YAMLConfigurator
      def initialize(config_path)
        # Save the config path for later use
        @config_path = config_path

        # Load options from the template
        @root_options = load_yaml "#{config_path}/_stevenson.yml"
      end

      def configure(path=nil, options=nil)
        # If no options are provided, use the root_options
        options ||= @root_options

        # If no path is provided, use the config_path
        path ||= @config_path

        # If the path is a directory, recursively configure that directory
        if File.directory? path
          # Iterate through each option provided
          options.each do |key, value|
            configure "#{path}/#{key}", value
          end
        else
          # If path is a file, load the YAML from that file
          config = load_yaml path

          # Collect answers for the config in the file
          config = collect_answers options, config

          # And save the config back to YAML file.
          save_yaml path, config
        end
      end

      private

      def collect_answers(options, config)
        if !options['question'] || options['question'].is_a?(Hash)
          # If the current option is not a leaf, iterate over its values
          options.each do |key, value|
            # If no key is present in the config, assign one
            config[key] = {} unless config[key]

            # Recursively collect answers for the current key in the config and
            # options
            config[key] = collect_answers value, config[key]
          end

          # Return the new config
          config
        else
          # If the option is not a hash, ask the user for input set the key in
          # the config to it
          ask_question options, config
        end
      end

      def load_yaml(path)
        # If a YAML file is present, load it
        if File.file? path
          result = YAML.load_file path
          result || {}
        else
          # Otherwise, return an empty hash
          {}
        end
      end

      def save_yaml(path, config)
        # Write config to path as YAML
        File.open(path, 'w') do |f|
          f.write config.to_yaml
        end
      end

      def ask_question(options, default_value)
        # Load the question text and highline options hash
        question = options['question']
        options.delete 'question'
  
        # Ask the user the question and apply all options
        answer = ask(question) do |q|
          q.default = default_value if default_value != {}
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
