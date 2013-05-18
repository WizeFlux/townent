namespace :stubhub do
  desc "Match results"
  task :match => :environment do
    StubHub::Event.where(location: [nil,nil]).delete_all
    StubHub::Event.each &:identify_event
  end
end