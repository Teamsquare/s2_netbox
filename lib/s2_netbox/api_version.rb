class S2Netbox::ApiVersion < S2Netbox::ApiRequest
  include S2Netbox::Helpers

  def self.get_version(session_id=nil)
    S2Netbox.request(S2Netbox::BASIC_ENDPOINT, build_command('GetAPIVersion'), session_id)
  end
end