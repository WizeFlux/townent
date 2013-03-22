class EventGroupsUpdater
  INTERVAL = 30.minutes
  
  def success(job)
    Delayed::Job.enqueue EventGroupsUpdater.new, priority: 60, queue: 'event_groups_updates', run_at: INTERVAL.from_now
  end

  def data_map(params)
    {
      sw_id: params['Id'],
      sw_name: params['Name'],
      sw_ticket_count: params['TicketCount'],
      sw_currency: params['Currency'],
      sw_min_price: params['MinPrice'],
      sw_url: params['SwURL'],
      sw_image_url: params['ImageURL'],
      category: Category.where(sw_id: params['CategoryId']).first
    }
  end
  
  def perform
    SeatWave.new.get_updated_event_groups(INTERVAL.ago).each do |event_group|
      target_event_group = EventGroup.where(sw_id: event_group['Id']).first
      
      
      if target_event_group
        target_event_group.update_attributes data_map(event_group)
      else
        EventGroup.create(data_map(event_group))
      end
    end
  end
end