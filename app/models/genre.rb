class Genre
  include Mongoid::Document
  
  field :_id, type: String, default: ->{sw_name.parameterize}
  
  
  ## Fields obtained from seatwave
  field :sw_id, type: String
  field :sw_name, type: String
  
  has_many :categories
  has_many :subcategories
  has_many :events
  has_many :event_groups
end
