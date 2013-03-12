class TicketGroupsFetcher
  include Traits::Initializer
  
  def perform
    sw_api.get_ticketgroups_for_event(parent.id).each do |tg|
      ticketgroup = TicketGroup.create({
        sw_id: tg['Id'],
        sw_qty: tg['Qty'],
        sw_qty_options: tg['QtyOptions'],
        sw_face_value_currency: tg['FaceValueCurrency'],
        sw_face_value: tg['FaceValue'],
        sw_currency: tg['Currency'],
        sw_price: tg['Price'],
        sw_comission: tg['Commission'],
        sw_url: tg['SwURL'],
        sw_delivery_type: tg['DeliveryType'],
        sw_block_id: tg['BlockId'],
        sw_tickettype_id: tg['TicketTypeID'],
        event: parent
      })
    end
  end
end
