class TicketTypesFetcher
  include Traits::Initializer
  
  def perform
    sw_api.get_tickettypes_for_event(parent.id).each do |tt|
      tickettype = TicketType.create({
        sw_id: tt['Id'],
        name: tt['TicketTypeName'],
        sw_ticket_count: tt['TicketCount'],
        sw_face_value_currency: tt['FaceValueCurrency'],
        sw_face_value: tt['FaceValue'],
        sw_currency: tt['Currency'],
        sw_min_price: tt['MinPrice'],
        event: parent
      })
    end
  end
end