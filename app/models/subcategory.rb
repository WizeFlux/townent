class Subcategory
  include Mongoid::Document
  
  field :name, type: String
  field :_id, type: String, default: ->{ name.parameterize if name}
  
  belongs_to :genre
  
  has_many :categories
  has_many :event_groups
end