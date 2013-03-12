class Event
  include Mongoid::Document
  
  field :_id, type: String, default: ->{sw_id}
  field :sw_id, type: String
  field :date, type: DateTime
  field :town, type: String
  field :country, type: String
  field :sw_venue_id, type: String
  field :sw_layout_id, type: String
  field :sw_url, type: String
  field :sw_currency, type: String
  field :sw_min_price, type: Float
  
  
  def fetch_ticket_groups
    Delayed::Job.enqueue TicketGroupsFetcher.new(self)
  end
  
  def fetch_ticket_types
    Delayed::Job.enqueue TicketTypesFetcher.new(self)
  end
  
  belongs_to :event_group
  has_many :ticket_types
  has_many :ticket_groups
end
