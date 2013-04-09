class City
  include Mongoid::Document
  
  ## Default things
  field :full_name, type: String, default: ->{ "#{sw_name}, #{sw_country_name}" }
  field :_id, type: String, default: ->{ full_name.parameterize }
  field :name, type: String, default: ->{ sw_name }
  
   


  field :sw_name, type: String
  field :sw_country_name, type: String


  ## Geolocation
  field :geocoded_name, type: String, default: ->{ geocoder_respond.city }
  field :location, type: Array, default: ->{ geocoder_respond.coordinates.reverse }
  index({ location: "2d" }, { min: -200, max: 200 })
  

  ## Relations
  belongs_to :country, index: true
  field :country_id, type: Mongoid::Fields::ForeignKey, default: ->{ identify_country.id }
  
  
  has_many :events
  has_many :event_groups
  
  private
  
  def identify_country
    @co ||= Country.find_or_create_by sw_name: sw_country_name
  end
  
  def geocoder_respond
    @gr ||= Geocoder.search(full_name).first
  end
end
