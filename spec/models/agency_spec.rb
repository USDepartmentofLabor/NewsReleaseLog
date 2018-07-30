require 'rails_helper'

RSpec.describe Agency, type: :model do
  
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