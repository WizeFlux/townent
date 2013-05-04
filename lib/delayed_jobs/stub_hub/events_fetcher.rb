class StubHub::EventsFetcher < Struct.new(:text)
  include StubHubDataMap
    
  def perform
    Stubhub::Event.
      search(text).
      each do |event|
        StubHub::Event.create stub_hub_event_dmap(event) unless StubHub::Event.where(id: event.id).exists?
      end
  end
end