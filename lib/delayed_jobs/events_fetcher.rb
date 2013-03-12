class EventsFetcher
  include Traits::Initializer
  
  def perform
    sw_api.get_events_for_eventgroup(parent.id).each do |event|
      Event.create({
        sw_id: event['Id'],
        date: sw_api.parse_date(event['Date']),
        town: event['Town'],
        country: event['Country'],
        sw_venue_id: event['VenueId'],
        sw_layout_id: event['LayoutId'],
        sw_url: event['SwURL'],
        sw_currency: event['Currency'],
        sw_min_price: event['MinPrice'],
        event_group: parent
      })
    end
  end
end