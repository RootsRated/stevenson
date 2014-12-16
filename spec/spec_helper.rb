require 'bundler/setup'
Bundler.setup

require 'stevenson'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.order = 'random'
end
