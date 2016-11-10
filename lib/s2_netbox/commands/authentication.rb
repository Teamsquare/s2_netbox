class S2Netbox::Commands::Authentication < S2Netbox::ApiRequest
  include S2Netbox::Helpers

  def self.login
    S2Netbox.request(S2Netbox::BASIC_ENDPOINT, build_command('Login', {:'USERNAME' => S2Netbox.configuration.username, :'PASSWORD' => S2Netbox.configuration.password}))
  end

  def self.logout(session_id)
    S2Netbox.request(S2Netbox::BASIC_ENDPOINT, build_command('Logout'), session_id)
  end
end