$("#events-list #container").append "<%= j(render 'events/units/events_set', events: @events, previous_event_date: params[:previous_event_date].to_date) =%>"