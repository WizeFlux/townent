class EventGroupsFetcher < Struct.new(:category_id)
  def perform
    SeatWave.new.get_event_groups_for_category(category_id).each do |event_group|
      EventGroup.create({
        sw_id: event_group['Id'],
        name: event_group['Name'],
        sw_ticket_count: event_group['TicketCount'],
        sw_currency: event_group['Currency'],
        sw_min_price: event_group['MinPrice'],
        sw_url: event_group['SwURL'],
        sw_image_url: event_group['ImageURL'],
        category: Category.find(category_id)
      })
    end
  end
end