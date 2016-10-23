class S2Netbox::ApiVersion
  def self.get_version(session_id=nil)
    S2Netbox.request(S2Netbox::BASIC_ENDPOINT, "<COMMAND name='GetAPIVersion' num='1'></COMMAND>", session_id)
  end
end