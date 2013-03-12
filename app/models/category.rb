class Category
  include Mongoid::Document

  field :_id, type: String, default: ->{sw_id}
  field :sw_id, type: String
  field :name

  def fetch_event_groups
    Delayed::Job.enqueue EventGroupsFetcher.new(self), priority: 20
  end
  
  has_many :event_groups
  belongs_to :genre
end
