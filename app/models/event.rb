class Event
  include Mongoid::Document
  
  
  ##Common things
  field :_id, type: String, default: ->{sw_id}
  
  
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
  
  
  belongs_to :category
  belongs_to :event_group
  belongs_to :genre
end