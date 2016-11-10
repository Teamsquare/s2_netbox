require 'spec_helper'

describe S2Netbox::Helpers do
  before(:each) do
    @dummy_class = DummyClass.new
  end

  describe 'blank?' do
    context 'when the string is empty' do
      it 'should return true' do
        expect(@dummy_class.blank?('')).to be_truthy
      end
    end

    context 'when the string is nil' do
      it 'should return true' do
        expect(@dummy_class.blank?(nil)).to be_truthy
      end
    end

    context 'when the string is neither empty nor nil' do
      it 'should return true' do
        expect(@dummy_class.blank?('test value')).to be_falsey
      end
    end
  end

end

class DummyClass
  include S2Netbox::Helpers
end