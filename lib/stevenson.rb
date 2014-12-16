require 'active_support/all'
require 'git'
require 'highline/import'
require 'stevenson/version'
require 'thor'
require 'yaml'

module Stevenson

  class Application < Thor
    desc 'stevenson new PROJECT_NAME', 'generates a Jekyll at PROJECT_NAME'

    def new(directory_name, template_url='https://github.com/RootsRated/hyde.git')
      # Git clone the Hyde repo to the given directory
      Git::Base.clone template_url, directory_name

      # Load config options from the directory
      options = load_options directory_name
      config = load_config directory_name

      # For each option, ask the user for input
      options.each do |key, value|
        config[key] = ask_question value, config[key]
      end

      # Save the updated config back to the directory
      File.open("#{directory_name}/_config.yml", 'w') do |f|
        f.write config.to_yaml
      end
    end

    private

    def load_options(directory_name)
      if File.file? "#{directory_name}/_stevenson.yml"
        YAML.load_file "#{directory_name}/_stevenson.yml"
      elsif File.file? "#{directory_name}/.stevenson.yml"
        YAML.load_file "#{directory_name}/.stevenson.yml"
      elsif File.file? "#{directory_name}/.stevenson"
        YAML.load_file "#{directory_name}/.stevenson"
      else
        say 'No _stevenson.yml file could be found in this template.'
        exit
      end
    end

    def load_config(directory_name)
      if File.file? "#{directory_name}/_config.yml"
        YAML.load_file "#{directory_name}/_config.yml"
      else
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
