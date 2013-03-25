namespace :updates do
  desc "Starting updates"
  task :start => :environment do
    Delayed::Job.enqueue EventGroupsUpdater.new, priority: 30, queue: 'event_groups_updates'
    Delayed::Job.enqueue EventsUpdater.new, priority: 40, queue: 'events_updates'
  end

  desc "Stopping updates"
  task :stop => :environment do
    Delayed::Job.where(:queue => 'events_updates').delete_all
    Delayed::Job.where(:queue => 'event_groups_updates').delete_all
  end
end