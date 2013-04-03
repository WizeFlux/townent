class Country
  include Mongoid::Document
  include Geocoder::Model::Mongoid


  ## Shared things
  field :_id, type: String, default: ->{name.parameterize}
  field :name, type: String
  field :code, type: String

  
  ## Geolocation
  field :coordinates, type: Array
  geocoded_by :name
  
  field :geocoded_name
  reverse_geocoded_by :coordinates do |record, result|
    record.geocoded_name = result.first.country
  end
  
  after_validation :geocode, :reverse_geocode
  
  
  ## Relations
  has_many :cities
  has_many :events
  has_many :event_groups
end
