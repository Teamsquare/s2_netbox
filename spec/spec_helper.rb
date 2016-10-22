require 'simplecov'

if ENV['CIRCLE_ARTIFACTS']
  require 'simplecov'
  dir = File.join("..", "..", "..", ENV['CIRCLE_ARTIFACTS'], "coverage")
  SimpleCov.coverage_dir(dir)
end
SimpleCov.start 'rails'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 's2_netbox'

RSpec.configure do |config|
  config.order = 'random'
end