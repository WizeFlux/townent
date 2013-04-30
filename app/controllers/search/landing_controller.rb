class Search::LandingController < ApplicationController
  helper_method :query_text
  
  def query_text
    params[:q] ? params[:q][:text] : nil
  end
  
  def index
    @events = Event.
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
  end
end
