require 'spec_helper'

describe S2Netbox::ApiRequest do
  describe 'build_params' do
    context 'simple params' do
      it 'can build an empty params list' do
        expect(S2Netbox::ApiRequest.build_params).to eq '<PARAMS></PARAMS>'
      end

      it 'correctly builds a non-empty params list' do
        expect(S2Netbox::ApiRequest.build_params({
                                                     :'USERNAME' => 'test',
                                                     :'PASSWORD' => 'a_password'
                                                 })).to eq '<PARAMS><USERNAME>test</USERNAME><PASSWORD>a_password</PASSWORD></PARAMS>'
      end
    end

    context 'nested params' do
      it 'correctly builds a nested list of params from lists of values' do
        expect(S2Netbox::ApiRequest.build_params({
                                                     :'LASTNAME' => 'Appleseed',
                                                     :'FIRSTNAME' => 'John',
                                                     :'ACCESSLEVELS' => {:singular_node_name => 'ACCESSLEVEL', :values => ['MEL2Member', 'MEL2T41']}
                                                 })).to eq '<PARAMS><LASTNAME>Appleseed</LASTNAME><FIRSTNAME>John</FIRSTNAME><ACCESSLEVELS><ACCESSLEVEL>MEL2Member</ACCESSLEVEL><ACCESSLEVEL>MEL2T41</ACCESSLEVEL></ACCESSLEVELS></PARAMS>'
      end
    end
  end

  describe 'build_command' do
    it 'builds a command with the correct name' do
      expect(S2Netbox::ApiRequest.build_command('Login')).to eq("<COMMAND name='Login' num='1'></COMMAND>")
    end

    it 'builds a command with params list' do
      expect(S2Netbox::ApiRequest.build_command('Login', {
          :'USERNAME' => 'test',
          :'PASSWORD' => 'a_password'
      })).to eq "<COMMAND name='Login' num='1'><PARAMS><USERNAME>test</USERNAME><PASSWORD>a_password</PASSWORD></PARAMS></COMMAND>"
    end
  end

  describe 'ruby styled attributes' do
    before :each do
      configure

      stub_request(:post, "https://test-s2.some.net/goforms/nbapi").
          with(:body => "APIcommand=<NETBOX-API sessionid='session_id'><COMMAND name='TestCommand' num='1'><PARAMS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID></PARAMS></COMMAND></NETBOX-API>").
          to_return(:status => 200, :body => "<NETBOX><RESPONSE command='TestCommand' num=\"1\"><CODE>SUCCESS</CODE><DETAILS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID></DETAILS></RESPONSE></NETBOX>", :headers => {})

      @result = S2Netbox::ApiRequest.send_request('TestCommand', {
          :person_id => '8a806ed6-0246-49d0-b7a7-ab6402da01e3'
      }, 'session_id')
    end

    it 'should be converted to S2 style arguments' do
      expect(@result).to be_a(S2Netbox::ApiResponse)
    end
  end

  describe 'map_attributes' do
    it 'converts attributes to S2 naming convention' do
      expect(S2Netbox::ApiRequest.map_attributes(
          {:first_name => 'Michael', :lastname => 'Shimmins', :'ACT_DATE' => '10/10/2016', :'EXPDATE' => '20/12/2016'}
      )).to eq({'FIRSTNAME' => 'Michael', 'LASTNAME' => 'Shimmins', 'ACTDATE' => '10/10/2016', 'EXPDATE' => '20/12/2016'})
    end

    it 'permits treats nil or empty values as empty elements' do
      expect(S2Netbox::ApiRequest.map_attributes(
          {:first_name => 'Michael', :lastname => 'Shimmins', :'ACT_DATE' => nil, :'EXPDATE' => ''}
      )).to eq({'FIRSTNAME' => 'Michael', 'LASTNAME' => 'Shimmins', 'ACTDATE' => '', 'EXPDATE' => ''})
    end
  end
end