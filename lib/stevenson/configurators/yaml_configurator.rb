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
        if !options['type'] || options['type'].is_a?(Hash)
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
          # Collect the appropriate answer for the given question
          Input.input_for(options).collect!
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
    end
  end
end
