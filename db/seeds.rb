sw_api = SeatWave.new

sw_api.get_genres.each do |g|
  
  
  ## Fetching genres to database
  genre = Genre.create({
    sw_id: g['Id'],
    sw_name: g['Name']
  })
  
  
  ## Fetching categories
  sw_api.get_categories_for_genre(g['Id']).each do |c|
    category = Category.create({
      sw_id: c['Id'],
      sw_name: c['Name'],
      genre: genre
    })
  end
end


## starting process of fetching huge things from api
Category.all.each do |category|
  category.fetch_event_groups
end