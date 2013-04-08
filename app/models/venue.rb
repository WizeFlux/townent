class Venue
  include Mongoid::Document
  include Geocoder::Model::Mongoid

  ## Shared Things
  field :_id, type: String, default: ->{ sw_name.parameterize + '-' + sw_id.parameterize }
  field :description, type: String
  field :full_address, type: String, default: -> { sw_address.values.join(', ') }

  ## Geolocation
  field :location, type: Array, default: ->{ [sw_lng, sw_lat] }
  index({ location: "2d" }, { min: -200, max: 200 })
  
  geocoded_by :full_address, :coordinates => :location
  
  after_validation :geocode_if_nedded
  
  def geocode_if_nedded
    geocode if (sw_lng == 0 && sw_lat == 0)
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
