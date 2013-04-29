class Search::EventsController < ApplicationController
  helper_method :query_text
  
  def query_text
    params[:q] ? params[:q][:text] : nil
  end
  
  def index
    @events = Event.
                full!.
                page(params[:page]).
                per(10).
                order_by_date.
                full_text_search(query_text)
  end
end