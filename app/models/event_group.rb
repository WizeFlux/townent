class EventGroup
  include Mongoid::Document
  
  field :_id, type: String, default: ->{sw_id}
  field :sw_id, type: String
  field :name, type: String
  field :sw_ticket_count, type: Integer
  field :sw_currency, type: String
  field :sw_min_price, type: Float
  field :sw_url, type: String
  field :sw_image_url, type: String
  
  
  def fetch_events
    Delayed::Job.enqueue EventsFetcher.new(self), priority: 10
  end
  
  
  has_many :events
  belongs_to :category
end
