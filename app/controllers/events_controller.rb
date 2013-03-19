class EventsController < ApplicationController
  # stream
  
  before_filter :find_category, :find_genre, :current_city
  helper_method :query_date_from, :query_date_to
  # before_filter :debugger
  


  def query
    params[:q] if params[:q]
  end
  
  def query_date_from
    query[:date_from] if query
  end
  
  def query_date_to
    query[:date_to] if query
  end
  
  def find_category
    @category ||= params[:category_id] ? Category.find(params[:category_id]) : nil
  end
  
  def find_genre
    @genre ||= params[:genre_id] ? Genre.find(params[:genre_id]) : nil
  end
  
  
  
  def index
    @events = Event.for_city(current_city)

    if @category
      @events = @events.for_category(@category)
    else
      @events = @events.for_genre(@genre) if @genre
    end
    
    if query && !query[:date_from].empty? && !query[:date_to].empty?
      @events = @events.for_dates_range(query_date_from.to_date, query_date_to.to_date)
    end
    
    @events = @events.limit(100)
    
    render stream: true
  end
end
