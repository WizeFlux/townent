class City
  include Mongoid::Document
  include Geocoder::Model::Mongoid  
  
  
  ## Default things
  field :_id, type: String, default: ->{name.parameterize + '-' + country.name.parameterize}
  field :name, type: String
  field :full_name, type: String, default: ->{name + ', ' + country.name}
  

  ## Geolocation
  field :coordinates, type: Array
  geocoded_by :full_name
  
  field :geocoded_name
  reverse_geocoded_by :coordinates do |record, result|
    record.geocoded_name = result.first.city
  end
  
  after_validation :geocode, :reverse_geocode


  ## Relations
  belongs_to :country
  has_many :events
  has_many :event_groups
end
