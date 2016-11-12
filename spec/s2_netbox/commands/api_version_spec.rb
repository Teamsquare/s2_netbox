require 'spec_helper'

describe S2Netbox::Commands::ApiVersion do
  context 'when a session_id is not specified' do
    before :each do
      configure

      stub_request(:post, "https://test-s2.some.net/goforms/nbapi").
          with(:body => "APIcommand=<NETBOX-API><COMMAND name='GetAPIVersion' num='1'></COMMAND></NETBOX-API>").
          to_return(:status => 200, :body => "<NETBOX><RESPONSE command='GetAPIVersion' num=\"1\"><CODE>SUCCESS</CODE><DETAILS><APIVERSION>4.1</APIVERSION></DETAILS></RESPONSE></NETBOX>", :headers => {})

      @result = S2Netbox::Commands::ApiVersion.get_version
    end

    it 'should be a S2Netbox::ApiResponse' do
      expect(@result).to be_a(S2Netbox::ApiResponse)
    end

    it 'should return the correct details' do
      expect(@result.details['APIVERSION']).to eq('4.1')
    end
  end

  context 'when a session_id is specified' do
    before :each do
      configure

      stub_request(:post, "https://test-s2.some.net/goforms/nbapi").
          with(:body => "APIcommand=<NETBOX-API sessionid='session_id'><COMMAND name='GetAPIVersion' num='1'></COMMAND></NETBOX-API>").
          to_return(:status => 200, :body => "<NETBOX><RESPONSE command='GetAPIVersion' num=\"1\"><CODE>SUCCESS</CODE><DETAILS><APIVERSION>4.1</APIVERSION></DETAILS></RESPONSE></NETBOX>", :headers => {})

      @result = S2Netbox::Commands::ApiVersion.get_version('session_id')
    end

    it 'should be a S2Netbox::ApiResponse' do
      expect(@result).to be_a(S2Netbox::ApiResponse)
    end

    it 'should return the correct details' do
      expect(@result.details['APIVERSION']).to eq('4.1')
    end
  end
end