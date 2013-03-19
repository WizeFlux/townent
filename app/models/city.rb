class City
  include Mongoid::Document
  
  field :_id, type: String, default: ->{name.parameterize + '-' + country.name.parameterize}
  field :name, type: String
  
  belongs_to :country
  has_many :events
end
