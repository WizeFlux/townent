class TicketGroupsFetcher < Struct.new(:event_id)
  
  def event
    Event.find(event_id)
  end
  
  def perform
    SeatWave.new.get_ticket_groups_for_event(event_id).each do |ticket_group|
      TicketGroup.create({
        sw_id: ticket_group['Id'],
        sw_qty: ticket_group['Qty'],
        sw_qty_options: ticket_group['QtyOptions'],
        sw_face_value_currency: ticket_group['FaceValueCurrency'],
        sw_face_value: ticket_group['FaceValue'],
        sw_currency: ticket_group['Currency'],
        sw_price: ticket_group['Price'],
        sw_comission: ticket_group['Commission'],
        sw_url: ticket_group['SwURL'],
        sw_delivery_type: ticket_group['DeliveryType'],
        sw_block_id: ticket_group['BlockId'],
        sw_tickettype_id: ticket_group['TicketTypeID'],
        event: event
      })
    end
  end
end
