class TicketTypesFetcher < Struct.new(:event_id)
  def perform
    SeatWave.new.get_ticket_types_for_event(event_id).each do |ticket_type|
      TicketType.create({
        sw_id: ticket_type['Id'],
        sw_name: ticket_type['TicketTypeName'],
        sw_ticket_count: ticket_type['TicketCount'],
        sw_face_value_currency: ticket_type['FaceValueCurrency'],
        sw_face_value: ticket_type['FaceValue'],
        sw_currency: ticket_type['Currency'],
        sw_min_price: ticket_type['MinPrice'],
        event: Event.find(event_id)
      })
    end
  end
end