class S2Netbox::Commands::ApiVersion < S2Netbox::ApiRequest
  provides_command :get_version

  def self.command_map
    {:get_version => 'GetAPIVersion'}
  end
end