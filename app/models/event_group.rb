class EventGroup
  include Mongoid::Document
  include Mongoid::Search
  include StubHubDataMap  

  ## Common things
  field :_id, type: String, default: ->{sw_name.parameterize}
  field :description, type: String
  field :is_moderated, type: Boolean, default: false

  #Text search
  search_in :sw_name, category: :sw_name, genre: :sw_name
  
  
  ## Obtained from Seatwave API
  field :sw_id, type: String
  field :sw_name, type: String
  field :sw_ticket_count, type: Integer
  field :sw_currency, type: String
  field :sw_min_price, type: Float
  field :sw_url, type: String
  field :sw_image_url, type: String
  field :sw_category_id
  
  
  

  
  ## Obtained from EchoNest API
  ##field :en_biography, type: String, default: ->{ EchoNest.new.get_biography_by_sw_id(sw_id) }
  
  
  
  #Image
  mount_uploader :avatar, BlobUploader
  def avatar_url; avatar? ? super : sw_image_url; end
  
  
  
  ## Relations
  has_many :stub_hub_events, class_name: 'StubHub::Event', inverse_of: :event_group
  
  def fetch_events_from_stub_hub
    Stubhub::Event.search("\"#{sw_name}\"").each {|event| StubHub::Event.create(stub_hub_event_dmap event, self)}
  end
  
  has_many :events
  
  belongs_to :category
  field :category_id, type: Mongoid::Fields::ForeignKey, default: ->{ Category.find_by(sw_id: sw_category_id).id }

  belongs_to :genre
  field :genre_id, type: Mongoid::Fields::ForeignKey, default: ->{ category.genre.id }
  
  belongs_to :subcategory
  field :subcategory_id, type: Mongoid::Fields::ForeignKey, default: ->{ category.subcategory.id if category.subcategory}
  
  
  index({category_id: 1, genre_id: 1}, {unique: true, background: false})
  index({category_id: 1}, {unique: true, background: false})

  
  default_scope includes(:category, :genre)
  
  scope :moderated, where(is_moderated: true)
  scope :awaiting_moderation, where(is_moderated: false)
  
  scope :for_genre, ->(genre){  genre ? where(genre_id: genre.id) : all  }  
  scope :for_subcategory, ->(subcategory){  subcategory ? where(subcategory_id: subcategory.id) : all  }
  scope :for_category, ->(category){  category ? where(category_id: category.id) : all  }
  scope :for_symbol, ->(symbol){  symbol ? where(sw_name: /^#{symbol}/) : all  }

  ## Buiding relations
  after_create do |event_group|
    Delayed::Job.enqueue EventsFetcher.new(event_group.sw_id), priority: 20, queue: 'events'
  end
end
