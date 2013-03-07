class Genre
  include Mongoid::Document
  
  field :_id, type: String, default: ->{sw_id}
  field :sw_id, type: String
  field :name, type: String
  
  has_many :categories
end
