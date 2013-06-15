require 'builder/xmlmarkup.rb'
include Townent::Application.routes.url_helpers

def default_url_options(options={})
    {:host => 'gdebilet.com'}
end

def map_url(xml, url, changefreq = 'weekly', priority = '1')
  xml.url { xml.loc url; xml.changefreq changefreq; xml.priority priority }
end

def map_sitemap(xml, url)
  xml.sitemap { xml.loc url }
end

def sitemap_file(filename, index_xml, robots_file, &block)
  file = File.new(Rails.root.join("public/sitemap-#{filename}.xml"), "w")
  xml = Builder::XmlMarkup.new :target => file; xml.instruct!
  xml.urlset :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9" do 
    yield xml
  end; file.close
  map_sitemap index_xml, "http://gdebilet.com/sitemap-#{filename}.xml"
  robots_file.puts "Sitemap: http://gdebilet.com/sitemap-#{filename}.xml"
end

namespace :sitemap do
  desc "Generate sitemap.xml"
  task :generate => :environment do
    File.open("public/robots.txt", 'w') do |robots|
      robots.puts "User-Agent: *\nSitemap: http://gdebilet.com/sitemap.xml"
      
      index_file = File.new(Rails.root.join("public/sitemap.xml"), "w")
      index_xml = Builder::XmlMarkup.new :target => index_file; index_xml.instruct!
      
      index_xml.sitemapindex :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9" do
        
        #Cities roots
        sitemap_file 'event-indexes', index_xml, robots do |xml|
          City.each{|city| map_url xml, city_events_url(city)} 
        end
 
        #Artists
        sitemap_file 'event-groups', index_xml, robots do |xml|
          EventGroup.each{ |event_group| map_url xml, event_group_url(event_group) }
        end
   
        #Venues
        sitemap_file 'venues', index_xml, robots do |xml|
          Venue.each{ |venue| map_url xml, venue_url(venue) }
        end

        #Events
        1.upto Event.page(1).per(2500).num_pages do |i|
          sitemap_file "events-#{i}", index_xml, robots do |xml|
            Event.page(i).per(2500).each{ |event| map_url xml, event_url(event) }
          end
        end
      end; index_file.close
    end
  end
end


