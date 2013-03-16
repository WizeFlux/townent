class EventsUpdater
  INTERVAL = 5.minutes
  
  def success(job)
    Delayed::Job.enqueue EventsUpdater.new, priority: 50, queue: 'events_updates', run_at: INTERVAL.from_now
  end

  def data_map(params)
    {
      sw_id: params['Id'],
      date: SeatWave.new.parse_date(params['Date']),
      town: params['Town'],
      country: params['Country'],
      sw_venue_id: params['VenueId'],
      sw_layout_id: params['LayoutId'],
      sw_url: params['SwURL'],
      sw_currency: params['Currency'],
      sw_min_price: params['MinPrice'],
      event_group: EventGroup.where(sw_id: params['EventGroupId']).first
    }
  end
  
  def perform
    SeatWave.new.get_updated_events(INTERVAL.ago).each do |event|
      
      target_event = Event.where(sw_id: event['Id']).first
      
      if target_event
        target_event.update_attributes data_map(event)
      else
        Event.create(data_map(event))
      end
      
    end
  end
end