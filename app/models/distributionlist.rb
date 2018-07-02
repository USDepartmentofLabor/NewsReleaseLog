class Distributionlist
  include Mongoid::Document
  field :description, type: String
  field :status, type: String
  field :abbr, type: String
  field :name, type: String
  has_and_belongs_to_many :news_logs , inverse_of: nil
end
