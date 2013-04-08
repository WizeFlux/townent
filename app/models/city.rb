class City
  include Mongoid::Document
  
  ## Default things
  field :_id, type: String, default: ->{ name.parameterize }
  field :name, type: String
  field :full_name, type: String, default: ->{ "#{name}, #{country.name}" }
   

  ## Geolocation
  field :geocoded_name, type: String, default: ->{ geocoder_respond.city }
  field :location, type: Array, default: ->{ geocoder_respond.coordinates.reverse }

  index({ location: "2d" }, { min: -200, max: 200 })
  
  after_validation :geocode

  ## Relations
  belongs_to :country, index: true
  has_many :events
  has_many :event_groups
  
  private
  
  def geocoder_respond
    @gr ||= Geocoder.search(full_name).first
  end
end
