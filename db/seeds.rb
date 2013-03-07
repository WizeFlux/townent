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
    
    ## Fetching eventgroups (shuold be something like performers)
    sw_api.get_eventgroups_for_category(c['Id']).each do |eg|
      eventgroup = EventGroup.create({
        sw_id: eg['Id'],
        name: eg['Name'],
        sw_ticket_count: eg['TicketCount'],
        sw_currency: eg['Currency'],
        sw_min_price: eg['MinPrice'],
        sw_url: eg['SwURL'],
        sw_image_url: eg['ImageURL'],
        category: category
      })
      
      ## Fetching events
      sw_api.get_events_for_eventgroup(eg['Id']).each do |e|
        event = Event.create({
          sw_id: e['Id'],
          date: sw_api.parse_date(e['Date']),
          town: e['Town'],
          country: e['Country'],
          sw_venue_id: e['VenueId'],
          sw_layout_id: e['LayoutId'],
          sw_url: e['SwURL'],
          sw_currency: eg['Currency'],
          sw_min_price: eg['MinPrice'],
          event_group: eventgroup    
        })
        
        ## Same for tickettypes
        sw_api.get_tickettypes_for_event(e['Id']).each do |tt|
          tickettype = TicketType.create({
            sw_id: tt['Id'],
            name: tt['TicketTypeName'],
            sw_ticket_count: tt['TicketCount'],
            sw_face_value_currency: tt['FaceValueCurrency'],
            sw_face_value: tt['FaceValue'],
            sw_currency: tt['Currency'],
            sw_min_price: tt['MinPrice'],
            event: event
          })
        end
        
        
        ## And for ticketgroups
        sw_api.get_ticketgroups_for_event(e['Id']).each do |tg|
          ticketgroup = TicketGroup.create({
            sw_id: tg['Id'],
            sw_qty: tg['Qty'],
            sw_qty_options: tg['QtyOptions'],
            sw_face_value_currency: tg['FaceValueCurrency'],
            sw_face_value: tg['FaceValue'],
            sw_currency: tg['Currency'],
            sw_price: tg['Price'],
            sw_comission: tg['Commission'],
            sw_url: tg['SwURL'],
            sw_delivery_type: tg['DeliveryType'],
            sw_block_id: tg['BlockId'],
            sw_tickettype_id: tg['TicketTypeID'],
            event: event
          })
        end
      end
    end
  end
end

