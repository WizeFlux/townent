class Category
  include Mongoid::Document

  field :_id, type: String, default: ->{sw_id}
  field :sw_id, type: String
  field :name
  
  has_many :event_groups
  belongs_to :genre
end
