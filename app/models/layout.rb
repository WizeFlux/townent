class Layout
  include Mongoid::Document
  
  field :_id, type: String, default: ->{sw_id}
  
  field :sw_id, type: String
  field :sw_name, type: String
  field :sw_venue_id, type: String
  field :sw_seat_map_url, type: String
  field :sw_seat_blocks, type: Array
  
  
  has_many :events
  belongs_to :venue
  field :venue_id, type: Mongoid::Fields::ForeignKey, default: ->{ Venue.find_by(sw_id: sw_venue_id).id }
  
  index({venue_id: 1}, {unique: true, background: false})
  
end