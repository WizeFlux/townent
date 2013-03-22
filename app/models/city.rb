class City
  include Mongoid::Document
  
  field :_id, type: String, default: ->{name.parameterize + '-' + country.name.parameterize}
  field :name, type: String
  field :full_name, type: String, default: ->{"#{name}, #{country.name}"}
  
  belongs_to :country
  has_many :events
  has_many :event_groups
end
