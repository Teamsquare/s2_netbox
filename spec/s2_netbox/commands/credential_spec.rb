require 'spec_helper'

describe S2Netbox::Commands::Credential do
  describe 'add' do
    before :each do
      configure

      stub_request(:post, "https://test-s2.some.net/goforms/nbapi").
          with(:body => "APIcommand=<NETBOX-API><COMMAND name='AddCredential' num='1'><PARAMS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID><ENCODEDNUM>8232</ENCODEDNUM><CARDFORMAT>26 bit Wiegand</CARDFORMAT></PARAMS></COMMAND></NETBOX-API>").
          to_return(:status => 200, :body => "<NETBOX><RESPONSE command='AddCredential' num=\"1\"><CODE>SUCCESS</CODE><DETAILS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID></DETAILS></RESPONSE></NETBOX>", :headers => {})

      @result = S2Netbox::Commands::Credential.add({
                                                              :person_id => '8a806ed6-0246-49d0-b7a7-ab6402da01e3',
                                                              :encodednum => '8232',
                                                              :card_format => '26 bit Wiegand'
                                                          })
    end

    it 'should be a S2Netbox::ApiResponse' do
      expect(@result).to be_a(S2Netbox::ApiResponse)
    end

    it 'should return the correct details' do
      expect(@result.details['PERSONID']).to eq('8a806ed6-0246-49d0-b7a7-ab6402da01e3')
    end
  end

  describe 'modify' do
    before :each do
      configure

      stub_request(:post, "https://test-s2.some.net/goforms/nbapi").
          with(:body => "APIcommand=<NETBOX-API sessionid='session_id'><COMMAND name='ModifyCredential' num='1'><PARAMS><ENCODEDNUM>8232</ENCODEDNUM><CARDFORMAT>26 bit Wiegand</CARDFORMAT><DISABLED>1</DISABLED></PARAMS></COMMAND></NETBOX-API>").
          to_return(:status => 200, :body => "<NETBOX><RESPONSE command='ModifyCredential' num=\"1\"><CODE>SUCCESS</CODE></RESPONSE></NETBOX>", :headers => {})

      @result = S2Netbox::Commands::Credential.modify({
                                                                 :encodednum => '8232',
                                                                 :card_format => '26 bit Wiegand',
                                                                 :disabled => '1'
                                                             }, 'session_id')
    end

    it 'should be a S2Netbox::ApiResponse' do
      expect(@result).to be_a(S2Netbox::ApiResponse)
    end
  end
end