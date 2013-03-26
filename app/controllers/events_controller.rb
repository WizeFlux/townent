class EventsController < ApplicationController
  before_filter :find_category, :find_genre, :find_city
  before_filter :find_event, except: %w(index)
  helper_method :query_date_from, :query_date_to, :query_scope



  ## Search form params
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
  def find_category
    @category ||= params[:category_id] ? Category.find(params[:category_id]) : nil
  end
  
  def find_city
    @city ||= params[:city_id] ? City.find(params[:city_id]) : nil
  end
  
  def find_genre
    @genre ||= params[:genre_id] ? Genre.find(params[:genre_id]) : nil
  end

  def find_event
    @event = Event.find params[:id]
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
    @events = Event.
      for_city(@city).
      from_date(query_date_from).
      to_date(query_date_to).
      for_category(@category).
      for_genre(@genre).
      includes(:event_group, :venue, :category, :genre).limit(100)
  end
end
