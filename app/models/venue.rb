class Venue
  include Mongoid::Document
  include Geocoder::Model::Mongoid

  ## Shared Things
  field :_id, type: String, default: ->{ sw_name.parameterize + '-' + sw_id.parameterize }
  field :description, type: String
  field :full_address, type: String, default: -> { sw_address.values.join(', ') }




  ## Geolocation
  field :location, type: Array, default: ->{ [sw_lng, sw_lat] }
  geocoded_by :full_address, :coordinates => :location
  index({ location: "2d" }, { min: -200, max: 200 })
  
  after_validation do |venue|
    venue.geocode if venue.location == [0.0, 0.0]
  end
  
  

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
