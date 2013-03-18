class EventsFetcher < Struct.new(:event_group_id)
  def perform
    SeatWave.new.get_events_for_event_group(event_group_id).each do |event|
      event_group = EventGroup.find(event_group_id)
      
      Event.create({
        #sw_data
        sw_id: event['Id'],
        sw_date: SeatWave.new.parse_date(event['Date']),
        sw_town: event['Town'],
        sw_country: event['Country'],
        sw_venue_id: event['VenueId'],
        sw_layout_id: event['LayoutId'],
        sw_url: event['SwURL'],
        sw_currency: event['Currency'],
        sw_min_price: event['MinPrice'],
        
        # realations stuff
        event_group: event_group,
        category: event_group.category,
        genre: event_group.category.genre
      })
    end
  end
end