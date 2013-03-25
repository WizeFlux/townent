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
  
  
  before_create :identify_venue
  def identify_venue
    venue = Venue.find_by(sw_id: sw_venue_id)
  end
end