class City
  include Mongoid::Document
  
  ## Default things
  field :full_name, type: String, default: ->{ "#{sw_name}, #{sw_country_name}" }
  field :_id, type: String, default: ->{ full_name.parameterize }
  field :name, type: String, default: ->{ sw_name }
  
   


  field :sw_name, type: String
  field :sw_country_name, type: String


  ## Geolocation
  field :geocoded_name, type: String, default: ->{ geocoder_respond.city if geocoder_respond}
  field :geocoded_country_name, type: String, default: ->{ geocoder_respond.country if geocoder_respond} 
  field :location, type: Array, default: ->{ geocoder_respond.coordinates.reverse if geocoder_respond}
  
  index({ location: "2d" }, { min: -200, max: 200 })
  index({ full_name: 1}, {background: false})

  ## Relations
  belongs_to :country
  field :country_id, type: Mongoid::Fields::ForeignKey, default: ->{ Country.find_or_create_by(sw_name: sw_country_name).id }

  index({country_id: 1}, {background: false})
  
  
  has_many :events
  has_many :venues
  
  private
  
  def geocoder_respond
    @gr ||= Geocoder.search(full_name).first
  end
end
