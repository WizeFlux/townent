class Country
  include Mongoid::Document

  field :_id, type: String, default: ->{name.parameterize}
  field :name, type: String

  field :code, type: String
  
  
  has_many :cities
  has_many :events
  has_many :event_groups
end
