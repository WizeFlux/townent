namespace :touch do
  desc "Touch EventGroups"
  task :event_groups => :environment do
    EventGroup.each &:save
  end

  desc "Touch Events"
  task :events => :environment do
    Event.each &:save
  end
end