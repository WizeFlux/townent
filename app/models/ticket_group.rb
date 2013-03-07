class TicketGroup
  include Mongoid::Document
  
  field :_id, type: String, default: ->{sw_id}
  field :sw_id, type: String
  field :sw_qty, type: Integer
  field :sw_qty_options, type: Array
  field :sw_face_value_currency, type: String
  field :sw_face_value, type: Float
  field :sw_currency, type: String
  field :sw_price, type: Float
  field :sw_comission, type: Float
  field :sw_url, type: String
  field :sw_delivery_type, type: Integer
  field :sw_block_id
  field :sw_tickettype_id
  
  
  belongs_to :ticket_type
  belongs_to :event
end
