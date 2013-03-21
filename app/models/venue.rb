class Venue
  include Mongoid::Document
  
  field :_id, type: String, default: ->{sw_id}
  field :description, type: String
  
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
