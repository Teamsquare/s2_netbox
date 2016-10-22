require 'spec_helper'

describe S2Netbox::Configuration do
  context 'when a valid configuration is supplied' do
    it 'should not raise an error' do
      expect {
        S2Netbox.configure 'https://test-s2', 'some_password'
      }.to_not raise_error
    end

    it 'should store the controller_url' do
      S2Netbox.configure 'https://test-s2', 'some_password'

      expect(S2Netbox.configuration.sha_password).to eq('some_password')
    end

    it 'should store the sha_password' do
      S2Netbox.configure 'https://test-s2', 'some_password'

      expect(S2Netbox.configuration.controller_url).to eq('https://test-s2')
    end
  end

  context 'when a valid configuration is not supplied' do
    it 'should raise an error if no sha_password is specfied' do
      expect {
        S2Netbox.configure 'https://test-s2', ''
      }.to raise_error
    end

    it 'should raise an error if no controller_url is specfied' do
      expect {
        S2Netbox.configure '', 'some_password'
      }.to raise_error
    end
  end
end
