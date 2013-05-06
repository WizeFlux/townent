module SeatWaveDataMap
  def layout_dmap(params)
    {
      sw_id: params['Id'],
      sw_name: params['Name'],
      sw_seat_map_url: params['SeatMapUrl'],
      sw_seat_blocks: params['SeatBlocks'],
      sw_venue_id: params['VenueId']
    }
  end
  
  def venue_dmap(params)
    {
      sw_id: params['Id'],
      sw_name: params['Name'],
      sw_lat: params['Lat'],
      sw_lng: params['Long'],
      sw_url: params['SwURL'],
      sw_image_url: params['ImageURL'],
      sw_address: params['Address']
    }
  end
  
  def event_dmap(params)
    {
      sw_id: params['Id'],
      sw_date: params['Date'],
      sw_town: params['Town'],
      sw_country: params['Country'],
      sw_venue_id: params['VenueId'],
      sw_layout_id: params['LayoutId'],
      sw_event_group_id: params['EventGroupId'],
      sw_url: params['SwURL'],
      sw_currency: params['Currency'],
      sw_min_price: params['MinPrice'],
      sw_ticket_count: params['TicketCount']
    }
  end
  
  def event_group_dmap(params)
    {
      sw_id: params['Id'],
      sw_name: params['Name'],
      sw_ticket_count: params['TicketCount'],
      sw_currency: params['Currency'],
      sw_min_price: params['MinPrice'],
      sw_url: params['SwURL'],
      sw_image_url: params['ImageURL'],
      sw_category_id: params['CategoryId']
    }
  end
end