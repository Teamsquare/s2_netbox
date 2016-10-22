require 'spec_helper'

describe S2Netbox::Configuration do
  before :each do
    S2Netbox.clear_configuration
  end

  describe 'clearing the configuration' do
    it 'should set the configuration to nil defaults' do
      S2Netbox.configure do |config|
        config.controller_url = 'https://test-s2'
        config.sha_password = 'some_password'
      end

      S2Netbox.clear_configuration

      expect(S2Netbox.configuration.controller_url).to be_nil
      expect(S2Netbox.configuration.sha_password).to be_nil
    end
  end

  describe 'setting the configuration' do
    it 'should raise an error if no controller_url is specified' do
      expect {
        S2Netbox.configure do |config|
          config.sha_password = 'some_password'
        end
      }.to raise_error(S2Netbox::Errors::ConfigurationError)
    end

    context 'using sha_password' do
      context 'when a valid configuration is supplied' do
        it 'should not raise an error' do
          expect {
            S2Netbox.configure do |config|
              config.controller_url = 'https://test-s2'
              config.sha_password = 'some_password'
            end
          }.to_not raise_error
        end

        it 'should store the controller_url' do
          S2Netbox.configure do |config|
            config.controller_url = 'https://test-s2'
            config.sha_password = 'some_password'
          end

          expect(S2Netbox.configuration.sha_password).to eq('some_password')
        end

        it 'should store the sha_password' do
          S2Netbox.configure do |config|
            config.controller_url = 'https://test-s2'
            config.sha_password = 'some_password'
          end

          expect(S2Netbox.configuration.controller_url).to eq('https://test-s2')
        end
      end

      context 'when a valid configuration is not supplied' do
        it 'should raise an error if sha_password is not specified' do
          expect {
            S2Netbox.configure do |config|
              config.controller_url = 'https://test-s2'
            end
          }.to raise_error(S2Netbox::Errors::ConfigurationError)
        end

        it 'should not accept both sha_password and username' do
          expect {
            S2Netbox.configure do |config|
              config.controller_url = 'https://test-s2'
              config.sha_password = 'some_password'
              config.username = 'some_username'
            end
          }.to raise_error(S2Netbox::Errors::ConfigurationError)
        end

        it 'should not accept both sha_password and password' do
          expect {
            S2Netbox.configure do |config|
              config.controller_url = 'https://test-s2'
              config.sha_password = 'some_password'
              config.password = 'some_password'
            end
          }.to raise_error(S2Netbox::Errors::ConfigurationError)
        end
      end
    end

    context 'using username and password' do
      context 'when a valid configuration is supplied' do

        it 'should not raise an error' do
          expect {
            S2Netbox.configure do |config|
              config.controller_url = 'https://test-s2'
              config.username = 'some_username'
              config.password = 'some_password'
            end
          }.to_not raise_error
        end

        it 'should store the controller_url' do
          S2Netbox.configure do |config|
            config.controller_url = 'https://test-s2'
            config.username = 'some_username'
            config.password = 'some_password'
          end

          expect(S2Netbox.configuration.controller_url).to eq('https://test-s2')
        end

        it 'should store the username' do
          S2Netbox.configure do |config|
            config.controller_url = 'https://test-s2'
            config.username = 'some_username'
            config.password = 'some_password'
          end

          expect(S2Netbox.configuration.username).to eq('some_username')
        end

        it 'should store the password' do
          S2Netbox.configure do |config|
            config.controller_url = 'https://test-s2'
            config.username = 'some_username'
            config.password = 'some_password'
          end

          expect(S2Netbox.configuration.password).to eq('some_password')
        end
      end

      context 'when a valid configuration is not supplied' do
        it 'should raise an error if password is not specified' do
          expect {
            S2Netbox.configure do |config|
              config.controller_url = 'https://test-s2'
              config.username = 'some_username'
            end
          }.to raise_error(S2Netbox::Errors::ConfigurationError)
        end

        it 'should raise an error if username is not specified' do
          expect {
            S2Netbox.configure do |config|
              config.controller_url = 'https://test-s2'
              config.password = 'some_password'
            end
          }.to raise_error(S2Netbox::Errors::ConfigurationError)
        end
      end
    end
  end
end
