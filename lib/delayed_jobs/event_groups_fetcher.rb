class EventGroupsFetcher
  include Traits::Initializer
  
  def success(job)
    parent.event_groups.each do |event_group|
      event_group.fetch_events
    end
  end
  
  def perform
    sw_api.get_eventgroups_for_category(parent.id).each do |eg|
      eventgroup = EventGroup.create({
        sw_id: eg['Id'],
        name: eg['Name'],
        sw_ticket_count: eg['TicketCount'],
        sw_currency: eg['Currency'],
        sw_min_price: eg['MinPrice'],
        sw_url: eg['SwURL'],
        sw_image_url: eg['ImageURL'],
        category: parent
      })
    end
  end
end