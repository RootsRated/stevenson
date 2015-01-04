require 'highline/import'

module Stevenson
  module Input
    class Text
      include Input::Base

      def initialize(options, default=nil)
        # Save the basic settings for the prompt
        @prompt = options['prompt'] || ''
        @default = default || options['default'] || ''
        @limit = options['limit'] || false
      end

      def collect!
        # Ask the user the question and apply the appropriate options
        answer = ask(@prompt) do |q|
          q.default = @default
          q.limit = @limit if @limit
        end

        # Return the user's answer
        answer.to_s
      end
    end
  end
end
