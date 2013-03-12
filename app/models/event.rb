class Event
  include Mongoid::Document
  
  
  ##Common things
  field :_id, type: String, default: ->{sw_id}
  
  
  ## Obtained from Seatwave API
  field :sw_id, type: String
  field :date, type: DateTime
  field :town, type: String
  field :country, type: String
  field :sw_venue_id, type: String
  field :sw_layout_id, type: String
  field :sw_url, type: String
  field :sw_currency, type: String
  field :sw_min_price, type: Float
  
  
  ## Inittial set of ticket group
  def fetch_ticket_groups
    Delayed::Job.enqueue TicketGroupsFetcher.new(id), priority: 80, queue: 'ticket_groups'
  end
  
  
  ## Inittial set of ticket types
  def fetch_ticket_types
    Delayed::Job.enqueue TicketTypesFetcher.new(id), priority: 70, queue: 'ticket_types'
  end


  
  belongs_to :event_group
  has_many :ticket_types
  has_many :ticket_groups
end