class EventGroup
  include Mongoid::Document
  
  ## Common things
  field :_id, type: String, default: ->{sw_id}
  
  
  ## Obtained from Seatwave API
  field :sw_id, type: String
  field :sw_name, type: String
  field :sw_ticket_count, type: Integer
  field :sw_currency, type: String
  field :sw_min_price, type: Float
  field :sw_url, type: String
  field :sw_image_url, type: String
  
  
  
  ## Sorry guys, but this trick from SeatWave really sucks, they send path if production instead of url in sandbox
  def image_url
    if Rails.env == 'production'
      "http://cdn2.seatwave.com/filestore" + sw_image_url
    else
      sw_image_url
    end
  end
  
  ## Fetch all nested events
  def fetch_events
    Delayed::Job.enqueue EventsFetcher.new(id), priority: 90, queue: 'events'
  end

  after_create :fetch_events

  has_many :events
  
  belongs_to :category
  belongs_to :genre
end
