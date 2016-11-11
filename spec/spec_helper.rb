require 'simplecov'

if ENV['CIRCLE_ARTIFACTS']
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], 'coverage')
  SimpleCov.coverage_dir(dir)
end

SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 's2_netbox'
require 'webmock/rspec'
require 'factory_girl'

Dir["#{File.expand_path('../../', __FILE__)}/spec/support/**/*.rb"].each { |file| require file }

RSpec.configure do |config|
  config.order = 'random'

  config.include ConfigurationHelper
end

WebMock.disable_net_connect!(:allow_localhost => true)