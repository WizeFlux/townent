class EventGroupsFetcher < Struct.new(:category_id)
  include SeatWaveDataMap
  
  def perform
    SeatWave.new.get_event_groups_for_category(category_id).each do |event_group_json_respond|
      EventGroup.create event_group_dmap(event_group_json_respond)
    end
  end
end