module ConfigurationHelper
  def configure
    S2Netbox.clear_configuration

    S2Netbox.configure do |config|
      config.controller_url = 'https://test-s2.some.net'
      config.username = 'some_password'
      config.password = 'some_password'
    end
  end
end
