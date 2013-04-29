class Event
  include Mongoid::Document
  include Mongoid::Search
  include SeatWaveDataMap
    
  
  
  ##Common things
  field :_id, type: String, default: ->{sw_id}
  field :description, type: String
  
  
  #Text search
  search_in category: :sw_name, genre: :sw_name, event_group: :sw_name
  

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
  belongs_to :event_group
  field :event_group_id, type: Mongoid::Fields::ForeignKey, default: ->{ EventGroup.find_by(sw_id: sw_event_group_id).id }
  
  belongs_to :category
  field :category_id, type: Mongoid::Fields::ForeignKey, default: ->{ event_group.category.id }
  
  belongs_to :genre
  field :genre_id, type: Mongoid::Fields::ForeignKey, default: ->{ event_group.genre.id }
  
  belongs_to :city
  field :city_id, type: Mongoid::Fields::ForeignKey, default: ->{ City.find_or_create_by(sw_name: sw_town, sw_country_name: sw_country).id }

  belongs_to :country
  field :country_id, type: Mongoid::Fields::ForeignKey, default: ->{ city.country.id }
  
  belongs_to :venue
  field :venue_id, type: Mongoid::Fields::ForeignKey, default: ->{ identify_venue.id }
  
  belongs_to :layout
  field :layout_id, type: Mongoid::Fields::ForeignKey, default: ->{ identify_layout.id }



  ## Indexing
  index({location: '2d'}, {min: -200, max: 200})
  index({category_id: 1, city_id: 1}, {background: false})
  index({city_id: 1, genre_id: 1}, {background: false})
  index({city_id: 1, genre_id: 1, category_id: 1}, {background: false})
  index({city_id: 1, sw_date: 1}, {background: false})
  index({city_id: 1, genre_id: 1, sw_date: 1}, {background: false})
  index({city_id: 1, genre_id: 1, category_id: 1, sw_date: 1}, {background: false})
  index({venue_id: 1}, {background: false})
  
  ## Geocoding
  field :location, type: Array, default: ->{ venue.location }
  

  
  ## Defauly scopes
  scope :full!, includes(:event_group, :venue, :category, :genre, :layout, :city, :country)
  
  
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
    if Venue.where(sw_id: sw_venue_id).exists?
      Venue.find_by(sw_id: sw_venue_id)
    else
      Venue.create venue_dmap(SeatWave.new.get_venue_by_id(sw_venue_id))
    end
  end
    
  def identify_layout
    if Layout.where(sw_id: sw_layout_id).exists?
      Layout.find_by(sw_id: sw_layout_id)
    else
      Layout.create layout_dmap(SeatWave.new.get_layout_by_id(sw_layout_id))
    end
  end
end