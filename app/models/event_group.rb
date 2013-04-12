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
  
  
  ## Obtained from EchoNest API
  ##field :en_biography, type: String, default: ->{ EchoNest.new.get_biography_by_sw_id(sw_id) }
  
  
  
  #Image
  mount_uploader :avatar, BlobUploader
  def avatar_url
    avatar? ? super : sw_image_url
  end
  
  
  
  ## Relations
  has_many :events
  
  ## Thats just for editing purposes
  belongs_to :country
  belongs_to :city
  
  ## Real one
  belongs_to :category
  field :category_id, type: Mongoid::Fields::ForeignKey, default: ->{ Category.find_by(sw_id: sw_category_id).id }

  belongs_to :genre
  field :genre_id, type: Mongoid::Fields::ForeignKey, default: ->{ category.genre.id }
  
  index({category_id: 1, genre_id: 1}, {unique: true, background: false})


  ## Buiding relations
  after_create do |event_group|
    Delayed::Job.enqueue EventsFetcher.new(event_group.sw_id), priority: 20, queue: 'events'
  end
end
