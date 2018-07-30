class Region
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :code, type: String
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
end
