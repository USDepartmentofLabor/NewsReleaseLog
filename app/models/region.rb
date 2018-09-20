class Region
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :code, type: String
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
  before_validation :capitalize_attributes

  def capitalize_attributes
    self.name = self.name.upcase
    self.code = self.code.upcase
  end
end
