class EventsController < ApplicationController
  before_filter :find_category, :find_genre, :find_city
  before_filter :find_event, except: %w(index)
  helper_method :query_date_from, :query_date_to, :query_scope, :request_coordinates, :nearby_cities

  ## Fetched form params
  def params_city
    City.find(params[:city_id]) if params[:city_id]
  end
  
  def query
    params[:q] if params[:q]
  end
  
  def query_scope
    query ? query[:scope] : 'all'
  end
  
  def query_date_from
    if query_scope == 'weekend'
      Date.today.at_end_of_week - 1.day
    else
      if query and query[:date_from]
        query[:date_from]
      else
        Date.today
      end
    end
  end
  
  def query_date_to
    if query_scope == 'weekend'
      Date.today.at_end_of_week
    else
      query ? query[:date_to] : nil
    end
  end
  


  ## Parents
  def find_city
    @city ||=  params_city || request_city || nil
  end
  
  def find_genre
    @genre ||= (Genre.find(params[:genre_id]) if params[:genre_id])
  end
  
  def find_category
    @category ||= (Category.find(params[:category_id]) if params[:category_id])
  end
  
  def find_event
    @event ||= Event.find params[:id]
  end
  
  
  
  ## Fetched from request
  def request_city
    @request_city ||= City.where(geocoded_name: request.location.city, country: request_country).first if request.location
  end

  def request_country
    @request_country ||= Country.where(geocoded_name: request.location.country).first if request.location
  end

  def request_coordinates
    @request_coordinates ||= [request.location.longitude, request.location.latitude] if request.location
  end

  def nearby_cities(coordinates, distance)
    City.near(coordinates, distance)
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
                  limit(100).
                  for_city(@city).
                  for_genre(@genre).
                  for_category(@category).
                  from_date(query_date_from).
                  to_date(query_date_to).
                  order_by_date
      
      @events = @events.
                  geo_near(request_coordinates).
                  max_distance(1).
                  distance_multiplier(6371).
                  spherical.
                  sort_by{|e| e.sw_date} if !@city
    end
  end
end
