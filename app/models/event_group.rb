class EventGroup
  include Mongoid::Document
  
  ## Common things
  field :_id, type: String, default: ->{sw_id}
  field :description, type: String
  
  
  ## Obtained from Seatwave API
  field :sw_id, type: String
  field :sw_name, type: String
  field :sw_ticket_count, type: Integer
  field :sw_currency, type: String
  field :sw_min_price, type: Float
  field :sw_url, type: String
  field :sw_image_url, type: String
  
  
  ## Fetch all nested events
  def fetch_events
    Delayed::Job.enqueue EventsFetcher.new(id), priority: 90, queue: 'events'
  end

  after_create :fetch_events

  ## Relations
  has_many :events
  
  belongs_to :country
  belongs_to :city
  belongs_to :category
  belongs_to :genre
end
