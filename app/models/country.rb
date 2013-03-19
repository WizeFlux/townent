class Country
  include Mongoid::Document

  field :_id, type: String, default: ->{name.parameterize}
  field :name, type: String
  
  has_many :cities
  has_many :events
end
