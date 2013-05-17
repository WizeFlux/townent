namespace :stubhub do
  desc "Match results"
  task :match => :environment do
    StubHub::Event.each &:identify_event
  end
end