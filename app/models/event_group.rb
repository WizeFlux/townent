class EventGroup
  include Mongoid::Document
  
  ## Common things
  field :_id, type: String, default: ->{sw_id}
  
  
  ## Obtained from Seatwave API
  field :sw_id, type: String
  field :name, type: String
  field :sw_ticket_count, type: Integer
  field :sw_currency, type: String
  field :sw_min_price, type: Float
  field :sw_url, type: String
  field :sw_image_url, type: String
  
  
  ## Inittial set of events
  def fetch_events
    Delayed::Job.enqueue EventsFetcher.new(id), priority: 90, queue: 'events'
  end
  

  has_many :events
  belongs_to :category
end
