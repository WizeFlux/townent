class SeatWave
  BASE_URI = URI.parse('http://api-sandbox.seatwave.com/v2/discovery/')
  JSON_PAGE_SIZE = 1000
  API_KEY = 'b37a2410e14b42d3b05271a56e27c111'
  API_SECRET = '0e33c2e557094234884fdd7290744731'

  def get_layout_by_id(id)
    item_fetcher('Layout', "layout/#{id}")
  end
  
  def get_venue_by_id(id)
    item_fetcher('Venue', "venue/#{id}")
  end
  
  def get_genres
    index_fetcher('Genres') {|page| fetch_json("genres", params(page))}
  end
  
  def get_categories_for_genre(id)
    index_fetcher('Categories') {|page| fetch_json("genre/#{id}/categories", params(page))}
  end
  
  def get_eventgroups_for_category(id)
    index_fetcher('EventGroups') {|page| fetch_json("category/#{id}/eventgroups", params(page))}
  end
  
  def get_events_for_eventgroup(id)
    index_fetcher('Events') {|page| fetch_json("eventgroup/#{id}/events", params(page))} 
  end

  def get_ticketgroups_for_event(id)
    index_fetcher('TicketGroups') {|page| fetch_json("event/#{id}/ticketgroups", params(page))}
  end

  def get_tickettypes_for_event(id)
    index_fetcher('TicketTypes') {|page| fetch_json("event/#{id}/tickettypes", params(page))}
  end
  
  def parse_date(date_string)
    parsed_date = /(\d{13})(\+\d{4})/.match(date_string)
    DateTime.strptime("#{parsed_date[1].to_i/1000} #{parsed_date[2]}", '%s %z')
  end
  
  private
  
  def item_fetcher(type, suffix)
    fetch_json(suffix, {apikey: API_KEY}.to_query)[type]
  end
  
  def index_fetcher(type, &block)
    respond = block.call(1)
    result, total_pages = respond[type], respond['Paging']['TotalPageCount']
    (2..total_pages).inject(result) {|rezult, page| rezult += block.call(page)[type]}
  end
  
  def fetch_json(suffix, parameters)
    uri = (BASE_URI + (suffix + '?' + parameters)).request_uri
    request = Net::HTTP::Get.new(uri, {'Accept' => 'application/json'})
    JSON.parse Net::HTTP.new(BASE_URI.host, BASE_URI.port).request(request).body
  end
  
  def params(page)
    {apikey: API_KEY, pgnumber: page, pgsize: JSON_PAGE_SIZE}.to_query
  end
end