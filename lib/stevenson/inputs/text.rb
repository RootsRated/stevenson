require 'highline/import'

module Stevenson
  module Inputs
    class Text
      def initialize(options, default=nil)
        # Save the basic settings for the prompt
        @prompt = options['prompt'] || ''
        @default = default || options['default'] || ''
        @is_secret = !options['secret'].nil?
        @is_email = !options['email'].nil?
        @is_url = !options['url'].nil?
        @limit = options['limit'] || false
      end

      def collect!
        # Ask the user the question and apply the appropriate options
        answer = ask(@prompt) do |q|
          q.default = @default
          q.echo = @is_secret
          q.validate = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i  if @is_email
          q.validate = /https?:\/\/[\S]+/  if @is_url
          q.limit = options['limit'] if @limit
        end

        # Return the user's answer
        answer.to_s
      end
    end
  end
end
