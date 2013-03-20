## This class contain data maps for Country, City, Venue, Layout, Event

class EventsFetcher < Struct.new(:event_group_id)
  def perform
    SeatWave.new.get_events_for_event_group(event_group_id).each do |event|

      event_group = EventGroup.find(event_group_id)
      country = Country.find_or_create_by(name: event['Country'])
      
      city = City.where(name: event['Town']).first
      venue = Venue.where(sw_id: event['VenueId']).first
      layout = Layout.where(sw_id: event['LayoutId']).first
      
      unless city
        city = City.create({
          name: event['Town'],
          country: country
        })
      end
      
      
      ## Shuld be separate task as well
      unless venue
        venue_json = SeatWave.new.get_venue_by_id(event['VenueId'])
        venue = Venue.create({
          sw_id: venue_json['Id'],
          sw_name: venue_json['Name'],
          sw_lat: venue_json['Lat'],
          sw_lng: venue_json['Long'],
          sw_url: venue_json['SwURL'],
          sw_image_url: venue_json['ImageURL'],
          sw_address: venue_json['Address']
        }) 
      end
      

      ## Shuld be separate task as well
      unless layout
        layout_json = SeatWave.new.get_layout_by_id(event['LayoutId'])
        layout = Layout.create({
          sw_id: layout_json['Id'],
          sw_name: layout_json['Name'],
          sw_seat_map_url: layout_json['SeatMapUrl'],
          sw_seat_blocks: layout_json['SeatBlocks'],
          venue: venue
        }) 
      end
      
      Event.create({
        #seat wave data
        sw_id: event['Id'],
        sw_date: SeatWave.new.parse_date(event['Date']),
        sw_town: event['Town'],
        sw_country: event['Country'],
        sw_venue_id: event['VenueId'],
        sw_layout_id: event['LayoutId'],
        sw_url: event['SwURL'],
        sw_currency: event['Currency'],
        sw_min_price: event['MinPrice'],
        sw_ticket_count: event['TicketCount'],
          
        # realations stuff
        event_group: event_group,
        category: event_group.category,
        genre: event_group.category.genre,
        venue: venue,
        layout: layout,
        city: city,
        country: country
      })
    end
  end
end