require 'rails_helper'

RSpec.describe Agency, type: :model do
  
  context 'when the agency is created' do
    it 'is valid with valid attributes' do
      agency = Agency.create(name: 'RAND', code: 'RAND')
      expect(agency).to be_valid
    end

    it 'is not valid without valid name' do
      agency = Agency.create(name: nil)
      expect(agency).to_not be_valid
    end

    it 'is not valid without valid code' do
      agency = Agency.create(code: nil)
      expect(agency).to_not be_valid
    end

    it 'is not valid unless both attributes are present' do
      agency = Agency.create(name: nil, code: nil)
      expect(agency).to_not be_valid
    end

    it 'is not valid if the attributes are duplicate' do
      Agency.create(name: 'RAND', code: 'RAND')
      duplicate_agency = Agency.create(name: 'RAND', code: 'RAND')
      expect(duplicate_agency).to_not be_valid
    end
  end

  context 'when the agency is updated' do
    it 'cannot be updated if the attributes are not valid' do
      agency = Agency.create(name: 'Test', code: 'TEST')
      agency.update(name: nil, code: nil)
      expect(agency).to_not be_valid
    end

    it 'cannot be updated if the attributes are duplicate' do
      agency_one = Agency.create(name: 'Test', code: 'TEST')
      agency_two = Agency.create(name: 'Rand', code: 'RAND')
      agency_two.update(name: 'Test', code: 'TEST')
      expect(agency_two).to_not be_valid
    end
  end
end