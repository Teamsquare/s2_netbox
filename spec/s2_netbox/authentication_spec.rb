require 'spec_helper'

describe S2Netbox::Authentication do

  before :each do
    configure
  end

  it 'should' do
    stub_request(:post, "https://test-s2.some.net/goforms/nbapi").
        with(:body => "APIcommand=<NETBOX-API><COMMAND name='Login' num='1'><PARAMS><USERNAME>some_password</USERNAME><PASSWORD>some_password</PASSWORD></PARAMS></COMMAND></NETBOX-API>").
        to_return(:status => 200, :body => "<RESPONSE></RESPONSE>", :headers => {})

    expect(S2Netbox::Authentication.login).to eq('true')

  end
end