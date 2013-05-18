class EventsController < ApplicationController
  before_filter :find_event, except: %w(index)
  before_filter :find_category, :find_genre, :find_city
  before_filter :set_session_city, only: %w(index)
  helper_method :query_date_from, :query_date_to, :query_scope, :query

  ## Fetched form params
  def params_city
    City.find(params[:city_id]) if params[:city_id]
  end
  
  def session_city
    City.find(session[:city_id]) if session[:city_id]
  end
  
  def query
    params[:q] if params[:q]
  end
  
  def query_scope
    query ? query[:scope] : 'all'
  end
  
  def query_date_from
    if query_scope == 'weekend'
      (Date.today.at_end_of_week - 1.day).strftime('%-d %B %Y')
    else
      if query and query[:date_from]
        query[:date_from]
      else
        (Date.today).strftime('%-d %B %Y')
      end
    end
  end
  
  def query_date_to
    if query_scope == 'weekend'
      (Date.today.at_end_of_week).strftime('%-d %B %Y')
    else
      query ? query[:date_to] : nil
    end
  end


  def set_session_city
    session[:city_id] = @city.id if @city
  end


  ## Parents
  def find_city
    @city ||=  params_city || session_city || request_city || (@event.city if @event)
  end
  
  def find_genre
    @genre ||= (Genre.find(params[:genre_id]) if params[:genre_id]) || (@event.genre if @event)
  end
  
  def find_category
    @category ||= (Category.find(params[:category_id]) if params[:category_id]) || (@event.category if @event)
  end
  
  def find_event
    @event ||= Event.find params[:id]
  end
  


  ## Actions
  def update
    if @event.update_attributes(params[:event])
      redirect_to @event
    else
      render 'edit'
    end
  end
  
  
  def index    
    if @city || request_coordinates
      @events = Event.
                  full!.
                  order_by_date.                  
                  for_city(@city).
                  for_genre(@genre).
                  to_date(query_date_to).
                  for_category(@category).
                  from_date(query_date_from)

      @events = Kaminari.paginate_array(
                  @events.
                  limit(10000).
                  geo_near(request_coordinates).
                  max_distance(1).
                  distance_multiplier(6371).
                  spherical.
                  sort_by{|e| e.sw_date}
                ) unless @city
    end
    @counter = @events.count
    @events = @events.page(params[:page]).per(20) if @events
  end
end
