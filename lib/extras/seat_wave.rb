class SeatWave
  BASE_URI = URI.parse('http://api-sandbox.seatwave.com/v2/discovery/')
  JSON_PAGE_SIZE = 1000
  API_KEY = 'b37a2410e14b42d3b05271a56e27c111'
  API_SECRET = '0e33c2e557094234884fdd7290744731'
  
  def get_genres
    index_fetcher('Genres') {|page| fetch_json("genres", page)}
  end
  
  def get_categories_for_genre(id)
    index_fetcher('Categories') {|page| fetch_json("genre/#{id}/categories", page)}
  end
  
  def get_eventgroups_for_category(id)
    index_fetcher('EventGroups') {|page| fetch_json("category/#{id}/eventgroups", page)}
  end
  
  def get_events_for_eventgroup(id)
    index_fetcher('Events') {|page| fetch_json("eventgroup/#{id}/events", page)} 
  end

  def get_ticketgroups_for_event(id)
    index_fetcher('TicketGroups') {|page| fetch_json("event/#{id}/ticketgroups", page)}
  end

  def get_tickettypes_for_event(id)
    index_fetcher('TicketTypes') {|page| fetch_json("event/#{id}/tickettypes", page)}
  end
  
  private
  
  def index_fetcher(type, &block)
    respond = block.call(1)
    result, total_pages = respond[type], respond['Paging']['TotalPageCount']
    (2..total_pages).inject(result) {|r, i| r += block.call(i)[type]}
  end
  
  def fetch_json(suffix, page)
    uri = (BASE_URI + (suffix + '?' + index_query_params(page))).request_uri
    request = Net::HTTP::Get.new(uri, {'Accept' => 'application/json'})
    JSON.parse Net::HTTP.new(BASE_URI.host, BASE_URI.port).request(request).body
  end
  
  def index_query_params(page)
    {apikey: API_KEY, pgnumber: page, pgsize: JSON_PAGE_SIZE}.to_query
  end
end