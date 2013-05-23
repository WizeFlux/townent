class StubHub::Event
  include Mongoid::Document
  
  ## Obtained from SOLR based StubHub interface
  field :stubhubDocumentId, type: String
  field :stubhubDocumentType, type: String
  field :event_id, type: String
  field :act_primary, type: String
  field :id, type: String
  field :active, type: String
  field :cancelled, type: String
  field :allowedtoconfirm, type: String
  field :allowedtosell, type: String
  field :ancestorGenreIds, type: String
  field :ancestorGeoIds, type: String
  field :channel, type: String
  field :channelId, type: String
  field :channelUrlPath, type: String
  field :channel_facet_str, type: String
  field :city, type: String
  field :date_confirm, type: String
  field :date_inhand, type: String
  field :date_last_modified, type: String
  field :date_onsale, type: String
  field :description, type: String
  field :desc_sort, type: String
  field :eventDate_facet_str, type: String
  field :eventGenreParentDescription_facet_str, type: String
  field :eventGeoDescription, type: String
  field :eventGeoDescription_text, type: String
  field :eventLocation_facet_str, type: String
  field :event_date, type: String
  field :event_date_local, type: String
  field :event_date_time_local, type: String
  field :event_time_local, type: String
  field :event_type, type: String
  field :evt_segmentation_id, type: String
  field :genreDateDesc, type: String
  field :genreUrlPath, type: String
  field :genre_grand_parent_id, type: String
  field :genre_grand_parent_name, type: String
  field :genre_parent, type: String
  field :genre_parent_name, type: String
  field :geoEventTypes, type: String
  field :geoUrlPath, type: String
  field :geography_parent, type: String
  field :hide_event_date, type: String
  field :image_url, type: String
  field :is_eticket_allowed, type: String
  field :is_integrated_team, type: String
  field :keywords, type: String
  field :last_chance, type: String
  field :maxPrice, type: Float
  field :maxSeatsTogether, type: Float
  field :meta_description, type: String
  field :minPrice, type: Float
  field :minSeatsTogether, type: Float
  field :name_primary, type: String
  field :name_secondary, type: String
  field :nickname, type: String
  field :seo_description, type: String
  field :seo_title, type: String
  field :spark_event_flag, type: String
  field :state, type: String
  field :threeLevelsUpIds, type: String
  field :title, type: String
  field :totalPostings, type: Integer
  field :totalTickets, type: Float
  field :type_id, type: String
  field :urlpath, type: String
  field :urlpathid, type: String
  field :venue_config_id, type: String
  field :venue_name, type: String
  field :venue_name_text, type: String
  field :venueconfigurationid, type: String
  field :zip, type: String
  field :artistPrimaryStyle, type: String
  field :is_event_package, type: String
  field :latitude, type: Float
  field :longitude, type: Float
  field :lat_lon, type: String
  field :date_added, type: String
  field :event_status_id, type: Integer
  field :timezone, type: String
  field :timezone_id, type: String
  field :venue_config_name, type: String
  field :updateInitiatedTimestamp, type: String
  field :book_of_business_id, type: Integer
  field :currency_code, type: String
  field :event_config_template_id, type: String
  field :event_config_template, type: String
  field :keywords_en_US, type: String
  field :event_type_en_US, type: String
  field :seo_title_en_US, type: String
  field :seo_description_en_US, type: String
  field :name_primary_en_US, type: String
  field :name_secondary_en_US, type: String
  field :act_primary_en_US, type: String
  field :title_en_US, type: String
  field :meta_description_en_US, type: String
  field :event_description_en_US, type: String
  field :jdk_timezone, type: String
  field :date_true_onsale, type: String
  field :ptv_integrated_event_ind, type: Integer
  field :venueDetailUrlPath, type: String
  field :access_control_method, type: Integer
  field :is_scrubbing_enabled, type: String
  field :view_from_section_ind, type: Integer
  field :bundled_type, type: String
  field :hide_event_time, type: Integer
  field :minListPrice, type: Float
  field :dateLastIndexed, type: String
  field :genreStartingAlphabet, type: Array
  field :allowedViewingDomain, type: Array
  field :locale, type: Array
  field :ancestorGeoDescriptions, type: Array
  field :ancestorGenreDescriptions, type: Array 
  
  field :location, type: Array, default: ->{ [longitude, latitude] }
  index({ location: "2d" }, { min: -200, max: 200 })
  
  
  field :local_date_time, type: DateTime, default: ->{ DateTime.strptime(event_date_time_local, '%Y-%m-%dT%TZ') }
  
  belongs_to :assigned_event, class_name: 'Event', inverse_of: :stub_hub_event
  index({assigned_event_id: 1}, {background: false})
  
  
  def identify_event
    self.update_attribute(
      :assigned_event,
      Event.
        where(local_date_time: local_date_time).
        limit(1).
        geo_near(location).
        max_distance(0.0005).
        first
    )
  end
end
