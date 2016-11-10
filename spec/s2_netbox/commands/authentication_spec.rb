require 'spec_helper'

describe S2Netbox::Commands::Authentication do

  describe 'login' do
    before :each do
      configure

      stub_request(:post, "https://test-s2.some.net/goforms/nbapi").
          with(:body => "APIcommand=<NETBOX-API><COMMAND name='Login' num='1'><PARAMS><USERNAME>some_password</USERNAME><PASSWORD>some_password</PASSWORD></PARAMS></COMMAND></NETBOX-API>").
          to_return(:status => 200, :body => "<NETBOX sessionid='255385874'><RESPONSE command='Login' num='1'><CODE>SUCCESS</CODE></RESPONSE></NETBOX>", :headers => {})

      @result = S2Netbox::Commands::Authentication.login
    end

    it 'should be a S2Netbox::ApiResponse' do
      expect(@result).to be_a(S2Netbox::ApiResponse)
    end

    it 'should return the correct session_id' do
      expect(@result.session_id).to eq('255385874')
    end
  end

  describe 'logout' do
    before :each do
      configure

      stub_request(:post, "https://test-s2.some.net/goforms/nbapi").
          with(:body => "APIcommand=<NETBOX-API sessionid='255385874'><COMMAND name='Logout' num='1'></COMMAND></NETBOX-API>").
          to_return(:status => 200, :body => "<NETBOX><RESPONSE command='Logout' num='1'><CODE>SUCCESS</CODE></RESPONSE></NETBOX>", :headers => {})

      @result = S2Netbox::Commands::Authentication.logout('255385874')
    end

    it 'should be a S2Netbox::ApiResponse' do
      expect(@result).to be_a(S2Netbox::ApiResponse)
    end
  end
end