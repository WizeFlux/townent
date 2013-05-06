# CSV.parse(File.open(Rails.root.join 'db/iso3166.csv')).each do |country|
#   Country.create code: country[0], name: country[1]
# end
# 
# 
# CSV.parse(File.open(Rails.root.join 'db/worldcities.utf-8.csv'), quote_char: '@') do |city|
#   City.create name: city[2], country: Country.find_by(code: city[0].upcase)
# end


Person.create(email: 'admin@gdebilet.com', password: 'holylaser')


SeatWave.new.get_genres.each do |g|
  
  
  ## Fetching genres to database
  genre = Genre.create({
    sw_id: g['Id'],
    sw_name: g['Name']
  })
  
  
  ## Fetching categories
  SeatWave.new.get_categories_for_genre(g['Id']).each do |c|
    category = Category.create({
      sw_id: c['Id'],
      sw_name: c['Name'],
      genre: genre
    })
  end
end


# starting process of fetching data from api
Category.all.each do |category|
  category.fetch_event_groups
end