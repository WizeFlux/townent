class EventsFetcher < Struct.new(:event_group_id)
  include SeatWaveDataMap
  
  def perform
    SeatWave.new.get_events_for_event_group(event_group_id).each do |event_json_respond|
      if event_group_id.to_s == event_json_respond['EventGroupId'].to_s
        Event.create event_dmap(event_json_respond)
      end
    end
  end
end