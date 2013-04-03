class Venue
  include Mongoid::Document
  include Geocoder::Model::Mongoid
  

  ## Shared Things
  field :_id, type: String, default: ->{sw_name.parameterize + '-' + sw_id.parameterize}
  field :description, type: String


  ## Geolocation
  field :coordinates, type: Array, default: ->{[sw_lng, sw_lat]}
  field :address, type: String ## Obtained from externat geocoding
  reverse_geocoded_by :coordinates
  after_validation :reverse_geocode
  

  ## Obtained from seatwave API
  field :sw_id, type: String
  field :sw_name, type: String
  field :sw_address, type: Hash
  field :sw_lat, type: Float
  field :sw_lng, type: Float
  field :sw_url, type: String
  field :sw_image_url, type: String
  
  
  ## Realtions
  has_many :events
  has_many :layouts
end
