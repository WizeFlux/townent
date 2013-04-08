class City
  include Mongoid::Document
  include Geocoder::Model::Mongoid
  
  
  ## Default things
  field :_id, type: String, default: ->{ name.parameterize }
  field :name, type: String
  field :full_name, type: String, default: ->{ "#{name}, #{country.name}" }
   

  ## Geolocation
  field :location, type: Array
  index({ location: "2d" }, { min: -200, max: 200 })
  
  
  field :geocoded_name, type: String, default: ->{ geocode; Geocoder.search(location.to_a.reverse).first.city }
  geocoded_by :full_name, :coordinates => :location

  ## Relations
  belongs_to :country, index: true
  has_many :events
  has_many :event_groups
end
