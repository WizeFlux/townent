class EventsFetcher < Struct.new(:event_group_id)
  
  def event_group
    EventGroup.find(event_group_id)
  end

  def success(job)
    event_group.events.each do |event|
      event.fetch_ticket_types
      event.fetch_ticket_groups
    end
  end
  
  def perform
    SeatWave.new.get_events_for_event_group(event_group_id).each do |event|
      Event.create({
        sw_id: event['Id'],
        date: SeatWave.new.parse_date(event['Date']),
        town: event['Town'],
        country: event['Country'],
        sw_venue_id: event['VenueId'],
        sw_layout_id: event['LayoutId'],
        sw_url: event['SwURL'],
        sw_currency: event['Currency'],
        sw_min_price: event['MinPrice'],
        event_group: event_group
      })
    end
  end
end