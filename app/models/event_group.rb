class EventGroup
  include Mongoid::Document
  
  ## Common things
  field :_id, type: String, default: ->{sw_id}
  field :description, type: String
  
  
  ## Obtained from Seatwave API
  field :sw_id, type: String
  field :sw_name, type: String
  field :sw_ticket_count, type: Integer
  field :sw_currency, type: String
  field :sw_min_price, type: Float
  field :sw_url, type: String
  field :sw_image_url, type: String
  field :sw_category_id
  

  ## Relations
  has_many :events
  

  ## Thats just for editing purposes
  belongs_to :country
  belongs_to :city
  
  
  ## Real one
  belongs_to :category
  belongs_to :genre


  ## Buiding relations
  after_create :initialize_relations, :fetch_events
  
  
  ## Fetch all nested events
  def fetch_events
    Delayed::Job.enqueue EventsFetcher.new(id), priority: 20, queue: 'events'
  end
  
  def initialize_relations
    update_attributes category: identify_category, genre: identify_genre
  end

  def identify_category
    Category.find_by(sw_id: sw_category_id)
  end
  
  def identify_genre
    identify_category.genre
  end
end
