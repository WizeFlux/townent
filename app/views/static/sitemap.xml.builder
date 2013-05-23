cache Date.today do
  xml.instruct!
  xml.urlset :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9" do
    
    City.each do |city|
      map_url xml, city_events_url(city)
      
      Genre.each do |genre|
        map_url xml, city_genre_events_url(city, genre)
        
        genre.categories.each do |category|
          map_url xml, city_genre_category_events_url(city, genre, category)
        end
      end
    end
    
    Event.each do |event|
      map_url xml, event_url(event)
    end
    
    EventGroup.each do |event_group|
      map_url xml, event_group_url(event_group)
    end
    
    Venue.each do |venue|
      map_url xml, venue_url(venue)
    end
  end
end