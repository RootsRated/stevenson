module Stevenson
  class Error < StandardError
    def initialize(message, cause = nil)
      super(message)
      @cause = cause
    end
  end
end
