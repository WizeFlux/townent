class EventGroupsController < ApplicationController
  before_filter :find_event_group
  helper_method :scope
  
  def find_event_group
    @event_group =  EventGroup.find params[:id]
  end
  
  def scope
    params[:scope] || 'upcoming'
  end
  
  def show 
    @events = case scope
      when 'upcoming'
        @event_group.events.for_dates_range(Time.now, 1.year.from_now)
      when 'past'
        @event_group.events.for_dates_range(1.year.ago, Time.now)        
      end
  end
  
  def update
    if @event_group.update_attributes(params[:event_group])
      redirect_to @event_group
    else
      render 'edit'
    end
  end
end
