class Event
  include Mongoid::Document
  
  
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
  field :sw_url, type: String
  field :sw_currency, type: String
  field :sw_min_price, type: Float
  field :sw_ticket_count, type: Integer
  
  
  ## Cached things
  field :cached_event_group_image_url, type: String
  field :cached_event_group_sw_name, type: String
  field :cached_venue_sw_name, type: String
  field :cached_genre_sw_name, type: String
  field :cached_category_sw_name, type: String
  
  
  ## Relations
  belongs_to :category
  belongs_to :event_group
  belongs_to :genre
  belongs_to :venue
  belongs_to :layout
  belongs_to :country
  belongs_to :city
  
  
  ## Default scopes
  default_scope order_by([[:sw_date, :asc]])
  
  
  ## Named scopes
  scope :for_date, ->(date){where(:sw_date.gte => date.beginning_of_day, :sw_date.lte => date.end_of_day)}
  scope :for_city, ->(city){where(city: city)}
  scope :for_genre, ->(genre){where(genre: genre)}
  scope :for_category, ->(category){where(category: category)}
  scope :for_dates_range, ->(date_from, date_to){where(:sw_date.gte => date_from, :sw_date.lte => date_to)}
  
  
  ## Callbacks
  after_create :cache!
  
  
  def cache!
    update_attributes({
      cached_event_group_image_url: event_group.image_url,
      cached_event_group_sw_name: event_group.sw_name,
      cached_venue_sw_name: venue.sw_name,
      cached_genre_sw_name: genre.sw_name,
      cached_category_sw_name: category.sw_name,
    })
  end
end