class Search::VenuesController < ApplicationController
  helper_method :query_text
  
  def query_text
    params[:q] ? params[:q][:text] : nil
  end
  
  def index
    @venues = Venue.
                page(params[:page]).
                per(30).
                full_text_search(query_text)
  end
end