require 'spec_helper'

describe S2Netbox do

  before(:each) do
    @dummy_class = DummyClass.new
  end

  describe 'build_params' do
    context 'simple params' do

      it 'can build an empty params list' do
        expect(@dummy_class.build_params).to eq '<PARAMS></PARAMS>'
      end

      it 'correctly builds a non-empty params list' do
        expect(@dummy_class.build_params({
                                             :'USERNAME' => 'test',
                                             :'PASSWORD' => 'a_password'
                                         })).to eq '<PARAMS><USERNAME>test</USERNAME><PASSWORD>a_password</PASSWORD></PARAMS>'
      end
    end

    context 'nested params' do
      it 'correctly builds a nested list of params from lists of values' do
        expect(@dummy_class.build_params({
                                             :'LASTNAME' => 'Appleseed',
                                             :'FIRSTNAME' => 'John',
                                             :'ACCESSLEVELS' => {:singular_node_name => 'ACCESSLEVEL', :values => ['MEL2Member', 'MEL2T41']}
                                         })).to eq '<PARAMS><LASTNAME>Appleseed</LASTNAME><FIRSTNAME>John</FIRSTNAME><ACCESSLEVELS><ACCESSLEVEL>MEL2Member</ACCESSLEVEL><ACCESSLEVEL>MEL2T41</ACCESSLEVEL></ACCESSLEVELS></PARAMS>'
      end
    end
  end

  describe 'build_command' do
    it 'builds a command with the correct name' do
      expect(@dummy_class.build_command('Login')).to eq("<COMMAND name='Login' num='1'></COMMAND>")
    end

    it 'builds a command with params list' do
      expect(@dummy_class.build_command('Login', {
          :'USERNAME' => 'test',
          :'PASSWORD' => 'a_password'
      })).to eq "<COMMAND name='Login' num='1'><PARAMS><USERNAME>test</USERNAME><PASSWORD>a_password</PASSWORD></PARAMS></COMMAND>"
    end
  end

  describe 'map_attributes' do
    it 'converts attributes to S2 naming convention' do
      expect(@dummy_class.map_attributes(
          {:first_name => 'Michael', :lastname => 'Shimmins', :'ACT_DATE' => '10/10/2016', :'EXPDATE' => '20/12/2016'}
      )).to eq({'FIRSTNAME' => 'Michael', 'LASTNAME' => 'Shimmins', 'ACTDATE' => '10/10/2016', 'EXPDATE' => '20/12/2016'})
    end
  end
end

class DummyClass
  include S2Netbox::Helpers
end
