require 'highline/import'
require 'json'
require 'net/http'
require 'yaml'

module Stevenson
  module Configurator
    class YAMLConfigurator
      def initialize(config_path)
        # Save the config path for later use
        @config_path = config_path

        # Load options from the template
        @root_options = load_yaml File.join(config_path, '_stevenson.yml')
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
        elsif options['type'] && options['type'] == 'select'
          # If the option has a type of select, produce a selection menu
          prompt_for_select options, config
        else
          # If the option is not a hash, assume a text question and ask the user
          # for input set the key in the config to it
          ask_question options, config
        end
      end

      def load_yaml(path)
        # If a YAML file is present, load it
        if File.file? path
          YAML.load_file(path) || {}
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

      def prompt_for_select(options, default_value)
        uri = URI(options['url'])
        raw_json = Net::HTTP.get uri
        json = JSON.parse raw_json

        list_key = options['list_key'] || ''
        name_key = options['name_key'] || ''
        value_key = options['value_key'] || ''

        menu_options = get_value_from_selector json, list_key

        choose do |menu|
          menu.prompt = options['question']

          menu_options.each do |menu_option|
            name = get_value_from_selector menu_option, name_key
            value = get_value_from_selector menu_option, value_key
            menu.choice(name) { value }
          end
        end
      end

      def ask_question(options, default_value)
        # Ask the user the question and apply all options
        answer = ask(options['question']) do |q|
          q.default = default_value if default_value != {}
          q.echo = false if options['secret']
          q.validate = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i  if options['email']
          q.validate = /https?:\/\/[\S]+/  if options['url']
          q.limit = options['limit'] if options['limit']
        end

        # Return the user's answer
        answer.to_s
      end

      def get_value_from_selector(hash, selector_string)
        selectors = selector_string.split '.'
        selectors.each do |selector|
          hash = hash[selector] if hash
        end
        hash
      end
    end
  end
end
