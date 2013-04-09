class VenuesController < ApplicationController
  before_filter :find_venue
  helper_method :scope
  
  def find_venue
    @venue = Venue.find params[:id]
  end
  
  def scope
    params[:scope] || 'upcoming'
  end
  
  def show 
    @events = case scope
      when 'upcoming' then @venue.events.order_by_date.from_date Time.now
      when 'past' then @venue.events.order_by_date.to_date Time.now
    end
  end
  
  def update
    if @venue.update_attributes(params[:venue])
      redirect_to @venue
    else
      render 'edit'
    end
  end
end
