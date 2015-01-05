require 'json'
require 'net/http'

module Stevenson
  module Input
    class Select
      include Base

      def initialize(options, default=nil)
        super

        # Save the basic settings for the prompt
        @prompt = options['prompt'] || ''

        # Load settings from remote sources, if any
        load_remote_options options['url'], options if options['url']
      end

      def collect!
        # Prompt the user with a menu using the provided settings
        choose do |menu|
          menu.prompt = @prompt

          options.each do |key, value|
            menu.choice(key) { value }
          end
        end
      end

      private

      def load_remote_options(url, options)
        # Download and parse the JSON to use for options
        uri = URI(url)
        raw_json = Net::HTTP.get uri
        json = JSON.parse raw_json

        # Get the appropriate keys for processing the JSON
        list_key = options['list_key'] || ''
        name_key = options['name_key'] || ''
        value_key = options['value_key'] || options['name_key'] || ''

        # Get the array of items to generate options for
        list_items = get_value_from_selector json, list_key

        # For each item, fetch the name and value for each option and assign them
        list_items.each do |list_item|
          name = get_value_from_selector list_item, name_key
          value = get_value_from_selector list_item, value_key
          options[name] = value
        end
      end

      def get_value_from_selector(hash, selector_string)
        # Split the provided selector into an array of selectors
        selectors = selector_string.split '.'

        # For each one, get the associated subhash from the hash
        selectors.each do |selector|
          hash = hash[selector] if hash
        end

        # Return the resulting hash
        hash
      end
    end
  end
end
