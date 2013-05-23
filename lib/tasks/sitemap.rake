require 'builder/xmlmarkup.rb'
include Townent::Application.routes.url_helpers

def default_url_options(options={})
    {:host => 'gdebilet.com'}
end

def map_url(xml, url, changefreq = 'weekly', priority = '1')
  xml.url do
    xml.loc url
    xml.changefreq changefreq
    xml.priority priority
  end
end

namespace :sitemap do
  desc "Generate sitemap.xml"
  task :generate => :environment do
    file = File.new(Rails.root.join("public/sitemap.xml"), "w")
    xml = Builder::XmlMarkup.new :target => file
    xml.instruct!

    xml.urlset :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9" do
      City.each do |city|
        map_url xml, city_events_url(city)
        Genre.each do |genre|
          map_url xml, city_genre_events_url(city, genre)
          genre.categories.each  { |category| map_url xml, city_genre_category_events_url(city, genre, category) }
        end
      end
      Event.each { |event| map_url xml, event_url(event) }
      EventGroup.each { |event_group| map_url xml, event_group_url(event_group) }
      Venue.each { |venue| map_url xml, venue_url(venue) }
    end

    file.close
  end
end


