class StubHub::Ticket
  include Mongoid::Document
  

  ## Obtained from SOLR based StubHub interface
  field :stubhubDocumentId, type: String
  field :stubhubDocumentType, type: String
  field :courier, type: String
  field :curr_price, type: Float
  field :curPr, type: Float
  field :date_added, type: String
  field :date_last_modified, type: String
  field :end_date, type: String
  field :delivery_icon, type: String
  field :event_id, type: String
  field :id, type: String
  field :priceGroups, type: String
  field :quantity, type: Integer
  field :quantity_facet_str, type: String
  field :quantity_remain, type: Integer
  field :row_desc, type: String
  field :sale_method, type: String
  field :seats, type: String
  field :section, type: String
  field :seller_cobrand, type: String
  field :seller_id, type: String
  field :showTicketKeyStr, type: String
  field :split_option, type: String
  field :status, type: String
  field :system_status, type: String
  field :ticket_list_type_desc, type: String
  field :ticket_list_type_id, type: String
  field :ticket_medium_id, type: String
  field :ticket_split, type: Integer
  field :time_left, type: String
  field :listing_source_id, type: String
  field :listing_source_name, type: String
  field :updateInitiatedTimestamp, type: String
  field :currency_code, type: String
  field :list_price, type: Float
  field :dateLastIndexed, type: String
  field :fm_dm_rules, type: Array
  field :fm_dm_rules_desc, type: Array
  
end
