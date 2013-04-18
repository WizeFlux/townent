module StubHubDataMap
  def stub_hub_event_dmap(params, parent)
    {
      stubhubDocumentId: params.stubhubDocumentId,
      stubhubDocumentType: params.stubhubDocumentType,
      event_id: params.event_id,
      act_primary: params.act_primary,
      id: params.id,
      active: params.active,
      cancelled: params.cancelled,
      allowedtoconfirm: params.allowedtoconfirm,
      allowedtosell: params.allowedtosell,
      ancestorGenreIds: params.ancestorGenreIds,
      ancestorGeoIds: params.ancestorGeoIds,
      channel: params.channel,
      channelId: params.channelId,
      channelUrlPath: params.channelUrlPath,
      channel_facet_str: params.channel_facet_str,
      city: params.city,
      date_confirm: params.date_confirm,
      date_inhand: params.date_inhand,
      date_last_modified: params.date_last_modified,
      date_onsale: params.date_onsale,
      description: params.description,
      desc_sort: params.desc_sort,
      eventDate_facet_str: params.eventDate_facet_str,
      eventGenreParentDescription_facet_str: params.eventGenreParentDescription_facet_str,
      eventGeoDescription: params.eventGeoDescription,
      eventGeoDescription_text: params.eventGeoDescription_text,
      eventLocation_facet_str: params.eventLocation_facet_str,
      event_date: params.event_date,
      event_date_local: params.event_date_local,
      event_date_time_local: params.event_date_time_local,
      event_time_local: params.event_time_local,
      event_type: params.event_type,
      evt_segmentation_id: params.evt_segmentation_id,
      genreDateDesc: params.genreDateDesc,
      genreUrlPath: params.genreUrlPath,
      genre_grand_parent_id: params.genre_grand_parent_id,
      genre_grand_parent_name: params.genre_grand_parent_name,
      genre_parent: params.genre_parent,
      genre_parent_name: params.genre_parent_name,
      geoEventTypes: params.geoEventTypes,
      geoUrlPath: params.geoUrlPath,
      geography_parent: params.geography_parent,
      hide_event_date: params.hide_event_date,
      image_url: params.image_url,
      is_eticket_allowed: params.is_eticket_allowed,
      is_integrated_team: params.is_integrated_team,
      keywords: params.keywords,
      last_chance: params.last_chance,
      maxPrice: params.maxPrice,
      maxSeatsTogether: params.maxSeatsTogether,
      meta_description: params.meta_description,
      minPrice: params.minPrice,
      minSeatsTogether: params.minSeatsTogether,
      name_primary: params.name_primary,
      name_secondary: params.name_secondary,
      nickname: params.nickname,
      seo_description: params.seo_description,
      seo_title: params.seo_title,
      spark_event_flag: params.spark_event_flag,
      state: params.state,
      threeLevelsUpIds: params.threeLevelsUpIds,
      title: params.title,
      totalPostings: params.totalPostings,
      totalTickets: params.totalTickets,
      type_id: params.type_id,
      urlpath: params.urlpath,
      urlpathid: params.urlpathid,
      venue_config_id: params.venue_config_id,
      venue_name: params.venue_name,
      venue_name_text: params.venue_name_text,
      venueconfigurationid: params.venueconfigurationid,
      zip: params.zip,
      artistPrimaryStyle: params.artistPrimaryStyle,
      is_event_package: params.is_event_package,
      latitude: params.latitude,
      longitude: params.longitude,
      lat_lon: params.lat_lon,
      date_added: params.date_added,
      event_status_id: params.event_status_id,
      timezone: params.timezone,
      timezone_id: params.timezone_id,
      venue_config_name: params.venue_config_name,
      updateInitiatedTimestamp: params.updateInitiatedTimestamp,
      book_of_business_id: params.book_of_business_id,
      currency_code: params.currency_code,
      event_config_template_id: params.event_config_template_id,
      event_config_template: params.event_config_template,
      keywords_en_US: params.keywords_en_US,
      event_type_en_US: params.event_type_en_US,
      seo_title_en_US: params.seo_title_en_US,
      seo_description_en_US: params.seo_description_en_US,
      name_primary_en_US: params.name_primary_en_US,
      name_secondary_en_US: params.name_secondary_en_US,
      act_primary_en_US: params.act_primary_en_US,
      title_en_US: params.title_en_US,
      meta_description_en_US: params.meta_description_en_US,
      event_description_en_US: params.event_description_en_US,
      jdk_timezone: params.jdk_timezone,
      date_true_onsale: params.date_true_onsale,
      ptv_integrated_event_ind: params.ptv_integrated_event_ind,
      venueDetailUrlPath: params.venueDetailUrlPath,
      access_control_method: params.access_control_method,
      is_scrubbing_enabled: params.is_scrubbing_enabled,
      view_from_section_ind: params.view_from_section_ind,
      bundled_type: params.bundled_type,
      hide_event_time: params.hide_event_time,
      minListPrice: params.minListPrice,
      dateLastIndexed: params.dateLastIndexed,
      genreStartingAlphabet: params.genreStartingAlphabet,
      allowedViewingDomain: params.allowedViewingDomain,
      locale: params.locale,
      ancestorGeoDescriptions: params.ancestorGeoDescriptions,
      ancestorGenreDescriptions: params.ancestorGenreDescriptions,
      event_group: parent
    }
  end
  
  def stub_hub_ticket_dmap(params)
    {
      
    }
  end
end