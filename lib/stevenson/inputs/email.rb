require 'highline/import'
require 'stevenson/inputs/text'

module Stevenson
  module Inputs
    class Email < Text
      def collect!
        # Ask the user the question and apply the appropriate options
        answer = ask(@prompt) do |q|
          q.default = @default
          q.validate = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
          q.limit = @limit if @limit
        end

        # Return the user's answer
        answer.to_s
      end
    end
  end
end
