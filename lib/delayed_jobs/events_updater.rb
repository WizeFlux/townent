class EventsUpdater
  include SeatWaveDataMap
  
  def interval
    30.minutes
  end
  
  def success(job)
    Delayed::Job.enqueue EventsUpdater.new, priority: 40, queue: 'events_updates', run_at: interval.from_now
  end
  
  def perform
    SeatWave.new.get_updated_events(interval.ago).each do |event_json_respond|

      if Event.where(sw_id: event_json_respond['Id']).exists?
        Event.find_by(sw_id: event_json_respond['Id']).update_attributes event_dmap(event_json_respond)
      else
        Event.create event_dmap(event_json_respond)
      end
      
    end
  end
end