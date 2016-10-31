require 'spec_helper'

describe S2Netbox::ApiResponse do
  context 'when the request was successful' do
    subject { FactoryGirl.build(:api_response) }

    it 'should assign code correctly' do
      expect(subject.code).to eq('SUCCESS')
    end

    it 'should assign error message correctly' do
      expect(subject.error_message).to be_nil
    end

    it 'successful? should return false' do
      expect(subject.successful?).to be_truthy
    end

    context 'when the response does not have any details' do
      subject { FactoryGirl.build(:api_response, :successful_login_response) }

      it 'details should be nil' do
        expect(subject.details).to be_nil
      end

      it 'error_message should be nil' do
        expect(subject.error_message).to be_nil
      end
    end

    context 'when the response has a root attribute' do
      subject { FactoryGirl.build(:api_response, :successful_login_response) }

      it 'details should be nil' do
        expect(subject.session_id).to eq('255385874')
      end
    end

    context 'when the details contains a nested list of attributes' do
      subject { FactoryGirl.build(:api_response, :nested_details) }

      it 'should have two vehicles' do
        expect(subject.details['VEHICLES']['VEHICLE'].length).to eq(2)
      end

      it 'should have a hash of attributes for each vehicle' do
        expect(subject.details['VEHICLES']['VEHICLE'][0]).to be_a(Hash)
        expect(subject.details['VEHICLES']['VEHICLE'][1]).to be_a(Hash)
      end

      it 'should have the correct attributes for each vehicle colour and make' do
        expect(subject.details['VEHICLES']['VEHICLE'][0]['VEHICLECOLOR']).to eq('Vehicle 1 Color')
        expect(subject.details['VEHICLES']['VEHICLE'][0]['VEHICLEMAKE']).to eq('Vehicle 1 Make')

        expect(subject.details['VEHICLES']['VEHICLE'][1]['VEHICLECOLOR']).to eq('Vehicle 2 Color')
        expect(subject.details['VEHICLES']['VEHICLE'][1]['VEHICLEMAKE']).to eq('Vehicle 2 Make')
      end

      it 'should have two access levels' do
        expect(subject.details['ACCESSLEVELS']['ACCESSLEVEL'].length).to eq(2)
      end

      describe 'access levels' do
        it 'should have access to MEL2 Members' do
          expect(subject.details['ACCESSLEVELS']['ACCESSLEVEL'][0]).to eq('MEL2_Member')
        end

        it 'should have access to Room 208 in MEL2' do
          expect(subject.details['ACCESSLEVELS']['ACCESSLEVEL'][1]).to eq('MEL2_208')
        end
      end
    end
  end

  context 'when the request was not successful' do
    subject { FactoryGirl.build(:api_response, :unsuccessful) }

    it 'should assign code correctly' do
      expect(subject.code).to eq('FAIL')
    end

    it 'should assign error message correctly' do
      expect(subject.error_message).to eq('Something went wrong')
    end

    it 'successful? should return false' do
      expect(subject.successful?).to be_falsey
    end
  end

  describe 'raw_request' do
    subject { FactoryGirl.build(:api_response) }

    it 'is assigned' do
      expect(subject.raw_request).to eq("APIcommand=<NETBOX-API><COMMAND name='GetAPIVersion' num='1'></COMMAND></NETBOX-API>")
    end
  end

  describe 'raw_response' do
    subject { FactoryGirl.build(:api_response) }

    it 'is assigned' do
      expect(subject.raw_response).to eq("<NETBOX><RESPONSE command='GetAPIVersion' num=\"1\"><CODE>SUCCESS</CODE><DETAILS><APIVERSION>4.1</APIVERSION></DETAILS></RESPONSE></NETBOX>")
    end
  end
end