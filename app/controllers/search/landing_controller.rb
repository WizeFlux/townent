class Search::LandingController < ApplicationController
  helper_method :query_text
  
  def query_text
    params[:q] ? params[:q][:text] : nil
  end
  
  def index
    @events = Event.
                full!.
                page(1).
                per(7).
                order_by_date.
                full_text_search(query_text)
                
    @event_groups = EventGroup.
                      page(1).
                      per(5).
                      full_text_search(query_text)
                      
    @venues = Venue.
                page(1).
                per(5).
                full_text_search(query_text)
                
    @events_counter = Event.full_text_search(query_text).count                        
    @event_groups_counter = EventGroup.full_text_search(query_text).count
    @venues_counter = Venue.full_text_search(query_text).count
  end
end
