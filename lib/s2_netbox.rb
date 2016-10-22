require 's2_netbox/version'

require 's2_netbox/error'
require 's2_netbox/errors/configuration_error'

require 's2_netbox/configuration'

module S2Netbox
  class << self
    def configure
      yield configuration
    ensure
      configuration.validate!
    end

    def configuration
      @configuration ||= S2Netbox::Configuration.new
    end

    def clear_configuration
      @configuration = nil
    end
  end
end
