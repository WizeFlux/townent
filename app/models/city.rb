class City
  include Mongoid::Document
  include Geocoder::Model::Mongoid
  include Mongoid::Spacial::Document
  
  
  ## Default things
  field :_id, type: String, default: ->{name.parameterize + '-' + country.name.parameterize}
  field :name, type: String
  field :full_name, type: String, default: ->{"#{name}, #{country.name}"}
  


  ## Geolocation
  field :coordinates, :type => Array, spacial: true
  geocoded_by :full_name
  after_validation :geocode  
    
    
  ## Relations
  belongs_to :country
  has_many :events
  has_many :event_groups
end
