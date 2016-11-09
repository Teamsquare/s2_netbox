require 'spec_helper'

describe S2Netbox::Person do
  describe 'add' do
    before :each do
      configure

      stub_request(:post, "https://test-s2.some.net/goforms/nbapi").
          with(:body => "APIcommand=<NETBOX-API><COMMAND name='AddPerson' num='1'><PARAMS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID><FIRSTNAME>Michael</FIRSTNAME><LASTNAME>Shimmins</LASTNAME><ACTDATE>10/10/2016</ACTDATE><UDF1>Teamsquare</UDF1><ACCESSLEVELS><ACCESSLEVEL>MEL2_Staff</ACCESSLEVEL><ACCESSLEVEL>MEL2_IT</ACCESSLEVEL></ACCESSLEVELS></PARAMS></COMMAND></NETBOX-API>").
          to_return(:status => 200, :body => "<NETBOX><RESPONSE command='AddPerson' num=\"1\"><CODE>SUCCESS</CODE><DETAILS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID></DETAILS></RESPONSE></NETBOX>", :headers => {})

      @result = S2Netbox::Person.add({
                                         :person_id => '8a806ed6-0246-49d0-b7a7-ab6402da01e3',
                                         :first_name => 'Michael',
                                         :last_name => 'Shimmins',
                                         :exp_date => nil,
                                         :act_date => '10/10/2016'
                                     }, %w(MEL2_Staff MEL2_IT), 'Teamsquare')
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
          with(:body => "APIcommand=<NETBOX-API><COMMAND name='ModifyPerson' num='1'><PARAMS><FIRSTNAME>Michael</FIRSTNAME><LASTNAME>Shimmins</LASTNAME><ACTDATE>10/10/2016</ACTDATE><UDF1>Teamsquare</UDF1><ACCESSLEVELS><ACCESSLEVEL>MEL2_Staff</ACCESSLEVEL><ACCESSLEVEL>MEL2_IT</ACCESSLEVEL></ACCESSLEVELS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID></PARAMS></COMMAND></NETBOX-API>").
          to_return(:status => 200, :body => "<NETBOX><RESPONSE command='ModifyPerson' num=\"1\"><CODE>SUCCESS</CODE><DETAILS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID></DETAILS></RESPONSE></NETBOX>", :headers => {})

      @result = S2Netbox::Person.modify('8a806ed6-0246-49d0-b7a7-ab6402da01e3', {
          :first_name => 'Michael',
          :last_name => 'Shimmins',
          :exp_date => nil,
          :act_date => '10/10/2016'
      }, %w(MEL2_Staff MEL2_IT), 'Teamsquare')
    end

    it 'should be a S2Netbox::ApiResponse' do
      expect(@result).to be_a(S2Netbox::ApiResponse)
    end

    it 'should return the correct details' do
      expect(@result.details['PERSONID']).to eq('8a806ed6-0246-49d0-b7a7-ab6402da01e3')
    end
  end

  describe 'add_credential' do
    before :each do
      configure

      stub_request(:post, "https://test-s2.some.net/goforms/nbapi").
          with(:body => "APIcommand=<NETBOX-API><COMMAND name='AddCredential' num='1'><PARAMS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID><ENCODEDNUM>8232</ENCODEDNUM><CARDFORMAT>26 bit Wiegand</CARDFORMAT></PARAMS></COMMAND></NETBOX-API>").
          to_return(:status => 200, :body => "<NETBOX><RESPONSE command='AddCredential' num=\"1\"><CODE>SUCCESS</CODE><DETAILS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID></DETAILS></RESPONSE></NETBOX>", :headers => {})

      @result = S2Netbox::Person.add_credential({
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
end