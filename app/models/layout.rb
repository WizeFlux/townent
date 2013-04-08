class Layout
  include Mongoid::Document
  
  field :_id, type: String, default: ->{sw_id}
  
  field :sw_id, type: String
  field :sw_name, type: String
  field :sw_venue_id, type: String
  field :sw_seat_map_url, type: String
  field :sw_seat_blocks, type: Array
  
  
  has_many :events
  belongs_to :venue, index: true
  field :venue_id, default: ->{ sw_venue_id }
end