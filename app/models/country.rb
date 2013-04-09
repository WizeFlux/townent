class Country
  include Mongoid::Document

  ## Shared things
  field :_id, type: String, default: ->{sw_name.parameterize}
  field :name, type: String, default: ->{sw_name}
  field :code, type: String

  field :sw_name, type: String
  
  ## Relations
  has_many :cities
  has_many :events
  has_many :event_groups
  
end
