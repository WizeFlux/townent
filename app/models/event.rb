class Event
  include Mongoid::Document
  include SeatWaveDataMap

  
  ##Common things
  field :_id, type: String, default: ->{sw_id}
  field :description, type: String
  
  
  ## Geocoding
  field :location, type: Array, default: ->{ identify_venue.location }
  index({ location: "2d" }, { min: -200, max: 200 })
  
  
  ## Obtained from Seatwave API
  field :sw_id, type: String
  field :sw_date, type: DateTime
  field :sw_town, type: String
  field :sw_country, type: String
  field :sw_venue_id, type: String
  field :sw_layout_id, type: String
  field :sw_event_group_id, type: String
  field :sw_url, type: String
  field :sw_currency, type: String
  field :sw_min_price, type: Float
  field :sw_ticket_count, type: Integer  
  
  
  ## Relations
  belongs_to :event_group, index: true
  field :event_group_id, type: Mongoid::Fields::ForeignKey, default: ->{ EventGroup.find_by(sw_id: sw_event_group_id).id }
  
  belongs_to :category, index: true
  field :category_id, type: Mongoid::Fields::ForeignKey, default: ->{ event_group.category.id }
  
  belongs_to :genre, index: true
  field :genre_id, type: Mongoid::Fields::ForeignKey, default: ->{ event_group.genre.id }
  
  belongs_to :country, index: true
  field :country_id, type: Mongoid::Fields::ForeignKey, default: ->{ identify_country.id }
  
  belongs_to :city, index: true
  field :city_id, type: Mongoid::Fields::ForeignKey, default: ->{ identify_city.id }
  
  belongs_to :venue, index: true
  field :venue_id, type: Mongoid::Fields::ForeignKey, default: ->{ identify_venue.id }
  
  belongs_to :layout, index: true
  field :layout_id, type: Mongoid::Fields::ForeignKey, default: ->{ identify_layout.id }

  ## Defauly scopes
  default_scope includes(:event_group, :venue, :category, :genre, :layout, :city, :country)
  
  
  ## Named scopes
  scope :order_by_date, ->{ order_by([[:sw_date, :asc]]) }
  scope :for_date, ->(date){  where(:sw_date.gte => date.beginning_of_day, :sw_date.lte => date.end_of_day)  }
  scope :for_city, ->(city){  city ? where(city_id: city.id) : all }
  scope :for_genre, ->(genre){  genre ? where(genre_id: genre.id) : all  }
  scope :for_category, ->(category){  category ? where(category_id: category.id) : all  }
  scope :from_date, ->(date_from){  date_from ? where(:sw_date.gte => date_from.to_date) : all  }
  scope :to_date, ->(date_to){  date_to ? where(:sw_date.lte => date_to.to_date) : all  }

  private
  
  def identify_venue
    @iv ||= if Venue.where(sw_id: sw_venue_id).exists?
      Venue.find_by(sw_id: sw_venue_id)
    else
      Venue.create venue_dmap(SeatWave.new.get_venue_by_id(sw_venue_id))
    end
  end
    
  def identify_layout
    @il ||= if Layout.where(sw_id: sw_layout_id).exists?
      Layout.find_by(sw_id: sw_layout_id)
    else
      Layout.create layout_dmap(SeatWave.new.get_layout_by_id(sw_layout_id))
    end
  end
  
  def identify_city
    @ict ||= City.find_or_create_by name: sw_town, country: identify_country
  end
  
  def identify_country
    @icn ||= Country.find_or_create_by name: sw_country
  end
end