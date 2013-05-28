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

def map_sitemap(xml, url)
  xml.sitemap { xml.loc url }
end

def sitemap_file(filename, &block)
  file = File.new(Rails.root.join("public/sitemap-#{filename}.xml"), "w")
  xml = Builder::XmlMarkup.new :target => file; xml.instruct!
  xml.urlset :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9" do
    yield xml
  end
  file.close
end


namespace :sitemap do
  desc "Generate sitemap.xml"
  task :generate => :environment do
    File.open("public/robots.txt", 'w') do |robots|
      robots.puts "User-Agent: *"
      
      index_file = File.new(Rails.root.join("public/sitemap.xml"), "w")
      index_xml = Builder::XmlMarkup.new :target => index_file; index_xml.instruct!
      index_xml.sitemapindex :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9" do
      
        sitemap_file 'event-indexes' do |xml|
          City.each{|city| map_url xml, city_events_url(city)} 
        end
        map_sitemap index_xml, "http://gdebilet.com/sitemap-event-indexes.xml"
        robots.puts "Sitemap: http://gdebilet.com/sitemap-event-indexes.xml"
    
        sitemap_file 'event-groups' do |xml|
          EventGroup.each{ |event_group| map_url xml, event_group_url(event_group) }
        end
        map_sitemap index_xml, "http://gdebilet.com/sitemap-event-groups.xml"
        robots.puts "Sitemap: http://gdebilet.com/sitemap-event-groups.xml"
        
        sitemap_file 'venues' do |xml|
          Venue.each{ |venue| map_url xml, venue_url(venue) }
        end
        map_sitemap index_xml, "http://gdebilet.com/sitemap-venues.xml"
        robots.puts "Sitemap: http://gdebilet.com/sitemap-venues.xml"
      
        1.upto Event.page(1).per(2500).num_pages do |i|
          sitemap_file "events-#{i}" do |xml|
            Event.page(i).per(2500).each{ |event| map_url xml, event_url(event) }
          end
          map_sitemap index_xml, "http://gdebilet.com/sitemap-events-#{i}.xml"
          robots.puts "Sitemap: http://gdebilet.com/sitemap-events-#{i}.xml"
        end

      end
      index_file.close
    end
  end
end


