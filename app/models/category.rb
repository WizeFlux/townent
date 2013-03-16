class Category
  include Mongoid::Document

  ## Common things
  field :_id, type: String, default: ->{sw_id}
  
  
  ## Seatwave api
  field :sw_id, type: String
  field :sw_name


  ## Obtain initial set of eventgroups
  def fetch_event_groups
    Delayed::Job.enqueue EventGroupsFetcher.new(id), priority: 100, queue: 'event_groups'
  end
  
  has_many :event_groups
  has_many :events
  belongs_to :genre
end
