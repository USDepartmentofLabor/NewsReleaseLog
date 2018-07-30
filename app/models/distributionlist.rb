class Distributionlist
  include Mongoid::Document
  include Mongoid::Timestamps
  field :description, type: String
  field :status, type: String
  field :abbr, type: String
  field :name, type: String
  has_and_belongs_to_many :news_logs , inverse_of: nil
  validates :name, presence: true, uniqueness: true
  validates :status, presence: true
  validates :description, presence: true
end
