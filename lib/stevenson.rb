require "active_support/all"
require "git"
require "highline/import"
require "stevenson/version"
require "yaml"

module Stevenson
  HYDE_URL = 'https://github.com/dylankarr/textNooga.git'

  class Console
    def create(project_name)
      # Git clone the Hyde repo to the given directory
      directory_name = project_name.underscore
      Git::Base.clone HYDE_URL, directory_name

      # Load config options from the directory
      options = YAML.load_file "#{directory_name}/_stevenson.yml"
      config = YAML.load_file "#{directory_name}/_config.yml"

      # For each option, ask the user for input
      options.each do |key, value|
        config[key] = ask_question value, config[key]
      end

      # Save the updated config back to the directory
      File.open("#{directory_name}/_config.yml", 'w') do |f|
        f.write config.to_yaml
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
