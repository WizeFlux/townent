class EchoNest
  CONFIG = YAML.load_file("#{Rails.root}/config/echo_nest.yml")[Rails.env]
  BASE_URI = URI.parse(CONFIG['base_url'])
  API_KEY = CONFIG['api_key']
  CONSUMER_KEY = CONFIG['consumer_key']
  SHARED_SECRET =  CONFIG['shared_secret']
    
  def get_biography_by_sw_id(id)
    fetch_json("artist/biographies", params(id).to_query)['response']


  end
  
  def fetch_json(suffix, parameters)
    uri = (BASE_URI + (suffix + '?' + parameters)).request_uri
    request = Net::HTTP::Get.new(uri, {'Accept' => 'application/json'})
    JSON.parse Net::HTTP.new(BASE_URI.host, BASE_URI.port).request(request).body
  end  
  
  def params(id)
    {
      api_key: API_KEY,
      id: "seatwave:artist:#{id}",
      format: 'json',
      results: 100,
      start: 0
    }
  end
end