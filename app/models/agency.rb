class Agency
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :code, type: String
end
