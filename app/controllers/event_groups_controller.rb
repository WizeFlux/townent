class EventGroupsController < ApplicationController
  before_filter :find_event_group, except: %w(index)
  before_filter :find_genre, :find_subcategory
  helper_method :query, :query_scope, :params_symbol
  
  def params_symbol
    case params[:symbol]
      when nil || '' then nil
      when '0-9' then '\d'
      else params[:symbol]
    end
  end
  
    
  def find_event_group
    @event_group = EventGroup.find params[:id]
  end
  
  def find_genre
    @genre ||= (Genre.find(params[:genre_id]) if params[:genre_id]) || Genre.first
  end
  
  def find_subcategory
    @category ||= (Subcategory.find(params[:subcategory_id]) if params[:subcategory_id]) || (@event_group.subcategory if @event_group)
  end
  
  def query
    params[:q] if params[:q]
  end
  
  def query_scope
    query ? query[:scope] : 'upcoming'
  end
  
  def show
    @events = @event_group.events.order_by_date.page(params[:page]).per(20)
    @events = @events.from_date(Time.now) if query_scope == 'upcoming'
    @events = @events.to_date(Time.now) if query_scope == 'past'
  end
  
  def update
    if @event_group.update_attributes(params[:event_group])
      redirect_to @event_group
    else
      render 'edit'
    end
  end
  
  
  def index
    @event_groups = EventGroup.
                      for_genre(@genre).
                      for_subcategory(@subcategory).
                      for_symbol(params_symbol).
                      page(params[:page]).
                      per(30)
  end
end
