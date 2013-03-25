class EventGroupsUpdater
  include SeatWaveDataMap
  
  def interval
    30.minutes
  end
  
  def success(job)
    Delayed::Job.enqueue EventGroupsUpdater.new, priority: 30, queue: 'event_groups_updates', run_at: interval.from_now
  end
  
  def perform
    SeatWave.new.get_updated_event_groups(interval.ago).each do |event_group_json_respond|
      
      if EventGroup.where(sw_id: event_group_json_respond['Id']).exists?
        EventGroup.find_by(sw_id: event_group_json_respond['Id']).update_attributes event_group_dmap(event_group_json_respond)
      else
        EventGroup.create event_group_dmap(event_group_json_respond)
      end
      
    end
  end
end