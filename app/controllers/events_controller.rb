class EventsController < ApplicationController
  before_filter :find_category, :find_genre, :current_city
  before_filter :find_event, except: %w(index)
  helper_method :query_date_from, :query_date_to

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

  def find_event
    @event = Event.find params[:id]
  end
  
  def update
    if @event.update_attributes(params[:event])
      redirect_to @event
    else
      render 'edit'
    end
  end
  
  
  def index
    @events = Event.
      for_city(current_city).
      from_date(query_date_from ? query_date_from : Date.today).
      to_date(query_date_to).
      for_category(@category).
      for_genre(@genre).
      includes(:event_group, :venue, :category, :genre).limit(100)
  end
end
