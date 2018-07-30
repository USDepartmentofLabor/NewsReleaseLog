require 'rails_helper'

RSpec.describe Region, type: :model do

  context 'when the region is created' do
    
    it 'is valid with attributes' do
      region = Region.create(name: 'Region', code: 'REG')
      expect(region).to be_valid
    end

    it 'is not valid without a valid name' do
      region = Region.create(name: nil)
      expect(region).to_not be_valid
    end

    it 'is not valid without a valid code' do
      region = Region.create(code: nil)
      expect(region).to_not be_valid
    end

    it 'is not valid unless  both attributes are present' do
      region = Region.create(name: nil, code: nil)
      expect(region).to_not be_valid
    end

    it 'is not valid if the attributes are duplicate' do
      Region.create(name: 'Region', code: 'REG')
      duplicate_region = Region.create(name: 'Region', code: 'REG')
      expect(duplicate_region).to_not be_valid 
    end
  end

  context 'when the region is updated' do
    it 'cannot be updated if the attributes are invalid' do
      region = Region.create(name: 'Region', code: 'REG')
      region.update(name: nil, code: nil)
      expect(region).to_not be_valid
    end

    it 'cannot be updated if the attributes are duplicate' do
      Region.create(name: 'Region', code: 'REG')
      region = Region.create(name: 'Test', code: 'TEST')
      region.update(name: 'Region', code: 'REG')
      expect(region).to_not be_valid
    end
  end
end