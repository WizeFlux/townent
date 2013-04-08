class SeatWave
  CONFIG = YAML.load_file("#{Rails.root}/config/seat_wave.yml")[Rails.env]
  BASE_URI = URI.parse(CONFIG['base_url'])
  JSON_PAGE_SIZE = CONFIG['page_size']
  API_KEY = CONFIG['api_key']
  API_SECRET = CONFIG['api_secret']
  SITE_ID =  CONFIG['site_id']

  ## Single items
  def get_event_by_id(id)
    item_fetcher('Event', "event/#{id}")
  end
  
  def get_event_group_by_id(id)
    item_fetcher('EventGroup', "eventgroup/#{id}")
  end
  
  def get_layout_by_id(id)
    item_fetcher('Layout', "layout/#{id}")
  end
  
  def get_venue_by_id(id)
    item_fetcher('Venue', "venue/#{id}")
  end
  
  
  
  ## Updates
  def get_updated_event_groups(updated_since)
    index_fetcher('EventGroups') do |page|
      fetch_json "eventgroups/updated", params(page) + '&' + {updatedSince: updated_since.httpdate.to_s}.to_query
    end
  end

  def get_updated_events(updated_since)
    index_fetcher('Events') do |page| 
      fetch_json "events/updated", params(page) + '&' + {updatedSince: updated_since.httpdate.to_s}.to_query
    end
  end



  ## Indexes
  def get_genres
    index_fetcher('Genres') {|page| fetch_json("genres", params(page))}
  end
  
  def get_categories_for_genre(id)
    index_fetcher('Categories') {|page| fetch_json("genre/#{id}/categories", params(page))}
  end
  
  def get_event_groups_for_category(id)
    index_fetcher('EventGroups') {|page| fetch_json("category/#{id}/eventgroups", params(page))}
  end
  
  def get_events_for_event_group(id)
    index_fetcher('Events') {|page| fetch_json("eventgroup/#{id}/events", params(page))} 
  end

  def get_ticket_groups_for_event(id)
    index_fetcher('TicketGroups') {|page| fetch_json("event/#{id}/ticketgroups", params(page))}
  end

  def get_ticket_types_for_event(id)
    index_fetcher('TicketTypes') {|page| fetch_json("event/#{id}/tickettypes", params(page))}
  end
  
  
  
  ## Helpful things
  def parse_date(date_string)
    parsed_date = /(\d{13})(\+\d{4})/.match(date_string)
    DateTime.strptime("#{parsed_date[1].to_i/1000} #{parsed_date[2]}", '%s %z')
  end
  
  def self.site_id
    SITE_ID
  end
  
  def self.api_key
    API_KEY 
  end
  
  def self.base_uri
    BASE_URI
  end
  
  private
  
  def item_fetcher(type, suffix)
    fetch_json(suffix, {apikey: API_KEY, siteid: SITE_ID}.to_query)[type]
  end
  
  def index_fetcher(type, &block)
    respond = block.call(1)
    raise "SeatWave API error: #{respond['Status']['Message']}" unless respond['Status']['Code'].to_i == 0
    
    result, total_pages = respond[type], respond['Paging']['TotalPageCount']
    
    (2..total_pages).inject(result) {|rezult, page| rezult += block.call(page)[type]}
  end
  
  def fetch_json(suffix, parameters)
    uri = (BASE_URI + (suffix + '?' + parameters)).request_uri
    request = Net::HTTP::Get.new(uri, {'Accept' => 'application/json'})
    JSON.parse Net::HTTP.new(BASE_URI.host, BASE_URI.port).request(request).body
  end
  
  
  def params(page)
    {apikey: API_KEY, pgnumber: page, pgsize: JSON_PAGE_SIZE, siteid: SITE_ID}.to_query
  end
end