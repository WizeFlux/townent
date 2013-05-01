class Category
  include Mongoid::Document

  ## Common things
  field :_id, type: String, default: ->{sw_name.parameterize}
  
  
  ## Seatwave api
  field :sw_id, type: String
  field :sw_name


  ## Obtain initial set of eventgroups
  def fetch_event_groups
    Delayed::Job.enqueue EventGroupsFetcher.new(sw_id), priority: 10, queue: 'event_groups'
  end
  
  has_many :event_groups
  has_many :events
  
  belongs_to :subcategory
  belongs_to :genre
  index({genre_id: 1}, {unique: true, background: false})
end
