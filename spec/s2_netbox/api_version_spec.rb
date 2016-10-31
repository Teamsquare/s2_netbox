require 'spec_helper'

describe S2Netbox::ApiVersion do

  before :each do
    configure
  end

  it 'should' do
    stub_request(:post, "https://test-s2.some.net/goforms/nbapi").
        with(:body => "APIcommand=<NETBOX-API><COMMAND name='GetAPIVersion' num='1'></COMMAND></NETBOX-API>").
        to_return(:status => 200, :body => "<NETBOX-API><RESPONSE command='GetAPIVersion' num=”1”><CODE>SUCCESS</CODE><DETAILS><APIVERSION>4.1</APIVERSION></DETAILS></RESPONSE></NETBOX-API>", :headers => {})

    expect(S2Netbox::ApiVersion.get_version).to eq('true')
  end
end