module Stevenson
  module Input
    class Password < Text
      include Base

      def collect!
        # Ask the user the question and apply the appropriate options
        answer = ask(@prompt) do |q|
          q.default = @default
          q.echo = @is_secret
          q.limit = @limit if @limit
        end

        # Return the user's answer
        answer.to_s
      end
    end
  end
end
