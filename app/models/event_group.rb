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
  
  has_many :events
  belongs_to :category
end
