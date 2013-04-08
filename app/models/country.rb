class Country
  include Mongoid::Document

  ## Shared things
  field :_id, type: String, default: ->{name.parameterize}
  field :name, type: String
  field :code, type: String

  
  ## Geolocation
  field :geocoded_name, type: String, default: ->{Geocoder.search(name).first.country}
  
  ## Relations
  has_many :cities
  has_many :events
  has_many :event_groups
  
end
