class Event
  include Mongoid::Document
  include Mongoid::Search
  include SeatWaveDataMap
    
  
  
  ##Common things
  field :_id, type: String, default: ->{sw_id}
  field :description, type: String
  field :local_date_time, type: DateTime, default: ->{  SeatWave.new.parse_date(sw_date) if sw_date  }
  
  #Text search
  search_in category: :sw_name, genre: :sw_name, event_group: :sw_name
  

  ## Obtained from Seatwave API
  field :sw_id, type: String
  field :sw_date, type: String
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


  has_one :stub_hub_event, class_name: 'StubHub::Event', inverse_of: :assigned_event
  
  
  ## Geocoding
  field :location, type: Array, default: ->{ venue.location if venue}


  ## Indexing
  index({location: '2d'}, {min: -200, max: 200})
  index({category_id: 1, city_id: 1}, {background: false})
  index({city_id: 1, genre_id: 1}, {background: false})
  index({city_id: 1, genre_id: 1, category_id: 1}, {background: false})
  index({city_id: 1, sw_date: 1}, {background: false})
  index({city_id: 1, genre_id: 1, sw_date: 1}, {background: false})
  index({city_id: 1, genre_id: 1, category_id: 1, sw_date: 1}, {background: false})
  index({venue_id: 1}, {background: false})
  



  ## Defauly scopes
  scope :full!, includes(:event_group, :venue, :category, :genre, :layout, :city, :country)
  
  
  ## Named scopes
  scope :order_by_date, ->{ order_by([[:local_date_time, :asc]]) }
  scope :for_date, ->(date){  where(:local_date_time.gte => date.beginning_of_day, :local_date_time.lte => date.end_of_day)  }
  scope :for_city, ->(city){  city ? where(city_id: city.id) : all }
  scope :for_genre, ->(genre){  genre ? where(genre_id: genre.id) : all  }
  scope :for_category, ->(category){  category ? where(category_id: category.id) : all  }
  scope :from_date, ->(date_from){  date_from ? where(:local_date_time.gte => date_from.to_date.beginning_of_day) : all  }
  scope :to_date, ->(date){  date ? where(:local_date_time.lte => date.to_date.end_of_day) : all  }

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
  
  after_create {|e| e.fetch_stubhub_events}
  
  def fetch_stubhub_events
    Delayed::Job.enqueue StubHub::EventsFetcher.new(event_group.sw_name + ' ' + venue.sw_name), priority: 20, queue: 'stubhub_events'
  end
  
end