class Venue
  include Mongoid::Document

  ## Shared Things
  field :_id, type: String, default: ->{ (sw_name + '-' + sw_id).parameterize }
  field :full_address, type: String, default: -> { sw_address.values.join(', ') }
  field :description, type: String





  ## Geolocation
  field :location, type: Array, default: ->{ identify_location }
  index({ location: "2d" }, { min: -200, max: 200 })
  
  def identify_location
    unless [sw_lng, sw_lat] == [0, 0]
      [sw_lng, sw_lat]
    else
      Geocoder.search(full_address).first.coordinates.reverse
    end
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
