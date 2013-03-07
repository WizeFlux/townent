class TicketType
  include Mongoid::Document

  field :_id, type: String, default: ->{sw_id}
  field :sw_id, type: String
  field :name, type: String
  field :sw_ticket_count, type: Integer
  field :sw_face_value_currency, type: String 
  field :sw_face_value, type: Float
  field :sw_currency, type: String
  field :sw_min_price, type: Float
  
  belongs_to :event
  has_many :ticket_groups
end
