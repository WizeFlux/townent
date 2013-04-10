class EventGroupsController < ApplicationController
  before_filter :find_event_group
  helper_method :query, :query_scope
  
  def find_event_group
    @event_group = EventGroup.find params[:id]
  end
  
  def query
    params[:q] if params[:q]
  end
  
  def query_scope
    query ? query[:scope] : 'all'
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
end
