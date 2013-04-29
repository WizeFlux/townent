class Search::EventGroupsController < ApplicationController
  helper_method :query_text
  
  def query_text
    params[:q] ? params[:q][:text] : nil
  end
  
  def index
    @event_groups = EventGroup.
                      page(params[:page]).
                      per(30).
                      full_text_search(query_text)
  end
end