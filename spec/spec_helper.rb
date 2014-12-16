require 'bundler/setup'
Bundler.setup

require 'helpers'
require 'stevenson'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.include Helpers
  config.order = 'random'
end
