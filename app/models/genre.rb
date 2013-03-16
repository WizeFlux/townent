class Genre
  include Mongoid::Document
  
  field :_id, type: String, default: ->{sw_id}
  
  
  ## Fields obtained from seatwave
  field :sw_id, type: String
  field :sw_name, type: String
  
  has_many :categories
end
