class Layout
  include Mongoid::Document
  
  field :_id, type: String, default: ->{sw_id}
  
  field :sw_id, type: String
  field :sw_name, type: String
  field :sw_seat_map_url, type: String
  field :sw_seat_blocks, type: Array
  
  belongs_to :venue
  has_many :events
end