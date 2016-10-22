require 's2_netbox/version'

require 's2_netbox/configuration'

module S2Netbox
  class << self
    def configure(controller_url, sha_password)
      if controller_url.nil? || controller_url.length == 0
        raise 'Must specify controller_url'
      end

      if sha_password.nil? || sha_password.length == 0
        raise 'Must specify sha_password'
      end


      configuration.controller_url = controller_url
      configuration.sha_password = sha_password
    end

    def configuration
      @configuration ||= S2Netbox::Configuration.new
    end
  end
end
