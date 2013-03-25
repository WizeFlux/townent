class Event
  include Mongoid::Document
  include SeatWaveDataMap
  
  ##Common things
  field :_id, type: String, default: ->{sw_id}
  field :description, type: String
  
  
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
  belongs_to :category
  belongs_to :genre
  belongs_to :country
  belongs_to :city
  belongs_to :venue
  belongs_to :layout  
  
  
  ## Default scopes
  default_scope order_by([[:sw_date, :asc]])
  
  
  ## Named scopes
  scope :for_date, ->(date){  where(:sw_date.gte => date.beginning_of_day, :sw_date.lte => date.end_of_day)  }
  scope :for_city, ->(city){  where(city: city)  }
  scope :for_genre, ->(genre){  genre ? where(genre: genre) : all  }
  scope :for_category, ->(category){  category ? where(category: category) : all  }
  scope :from_date, ->(date_from){  date_from ? where(:sw_date.gte => date_from.to_date) : all  }
  scope :to_date, ->(date_to){  date_to ? where(:sw_date.lte => date_to.to_date) : all  }
  
  
  ## Building relations
  after_create :initialize_relations
  
  
  ## Identify relations
  def initialize_relations
    update_attributes({ event_group: identify_event_group,
                        category: identify_category,
                        genre: identify_genre,
                        country: identify_country,
                        city: identify_city,
                        venue: identify_venue,
                        layout: identify_layout })
  end
  
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
  
  def identify_city
    City.find_or_create_by(name: sw_town, country: identify_country)
  end
  
  def identify_country
    Country.find_or_create_by(name: sw_country)
  end
  
  def identify_genre
    identify_event_group.genre
  end
  
  def identify_category
    identify_event_group.category
  end
  
  def identify_event_group
    EventGroup.find_by(sw_id: sw_event_group_id)
  end
end