class EventGroupsController < ApplicationController
  before_filter :find_event_group
  helper_method :scope
  
  def find_event_group
    @event_group = EventGroup.find params[:id]
  end
  
  def scope
    params[:scope] || 'upcoming'
  end
  
  def show 
    @events = case scope
      when 'upcoming' then @event_group.events.order_by_date.from_date Time.now
      when 'past' then @event_group.events.order_by_date.to_date Time.now
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
