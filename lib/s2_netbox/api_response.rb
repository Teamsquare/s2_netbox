require 'active_support/core_ext/hash'

class S2Netbox::ApiResponse
  attr_accessor :code, :success, :details, :error_message, :raw_request, :raw_response, :session_id

  def initialize(raw_request, raw_response)
    response_hash = Hash.from_xml(raw_response)

    @code = response_hash['NETBOX']['RESPONSE']['CODE']
    @success = @code == 'SUCCESS'
    @details = response_hash['NETBOX']['RESPONSE']['DETAILS']
    @error_message = details['ERRMSG'] if details

    @raw_request = raw_request
    @raw_response = raw_response
    @session_id = response_hash['NETBOX']['sessionid']
  end

  def successful?
    @success
  end
end