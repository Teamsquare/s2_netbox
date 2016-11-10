class S2Netbox::Commands::Credential < S2Netbox::ApiRequest
  def self.supported_operations
    %w(add modify)
  end
end