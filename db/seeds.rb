sw_api = SeatWave.new

sw_api.get_genres.each do |g|
  
  ## Fetching genres to database
  genre = Genre.create({
    sw_id: g['Id'],
    name: g['Name']
  })
  
  ## Fetching categories
  sw_api.get_categories_for_genre(g['Id']).each do |c|
    category = Category.create({
      sw_id: c['Id'],
      name: c['Name'],
      genre: genre
    })
  end
end


Category.all.each do |category|
  category.fetch_event_groups
end