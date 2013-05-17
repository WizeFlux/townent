namespace :cleanup do
  desc "Cleanup broken data"
  task :all => :environment do
    [
      Event.where(location: nil),
      Event.where(location: [nil, nil]),
      Venue.where(location: nil),
      Venue.where(location: [nil, nil])
    ].each(&:delete_all)
  end
end
