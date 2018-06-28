class Distributionlist
  include Mongoid::Document
  field :description, type: String
  field :status, type: String
  field :abbr, type: String
  field :name, type: String
end
