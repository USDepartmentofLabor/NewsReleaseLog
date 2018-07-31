require 'rails_helper'

RSpec.describe Distributionlist, type: :model do

  context 'when the distribution list is created' do
    it 'is valid with valid attributes' do
      distribution = Distributionlist.create(name: 'Testing', abbr: 'Test', status: 'D', description: 'Some random description')
      expect(distribution).to be_valid
    end

    it 'is not valid with invalid attributes' do
      distribution = Distributionlist.create(name: nil, abbr: nil, status: nil, description: nil)
      expect(distribution).to_not be_valid
    end
  end

  context 'when the distribution list is updated' do
    it 'can be updated with valid attributes' do
      distribution = Distributionlist.create(name: 'Testing', abbr: 'Test', status: 'D', description: 'Some random description')
      distribution.update(name: 'Updated', abbr: 'Upd', status: 'A', description: 'Updated description')
      expect(distribution).to be_valid
    end

    it 'cannot be updated without valid attributes' do
      distribution = Distributionlist.create(name: 'Testing', abbr: 'Test', status: 'D', description: 'Some random description')
      distribution.update(name: nil, abbr: nil, status: nil, description: nil)      
      expect(distribution).to_not be_valid
    end
  end
end
