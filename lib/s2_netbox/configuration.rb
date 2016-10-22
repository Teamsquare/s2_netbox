class S2Netbox::Configuration
  attr_accessor :sha_password
  attr_accessor :controller_url

  def initialize
    @controller_url = nil
    @sha_password = nil
  end
end