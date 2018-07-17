class Region
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :code, type: String
  validates :name, presence: true
  validates :code, uniqueness: true
end
