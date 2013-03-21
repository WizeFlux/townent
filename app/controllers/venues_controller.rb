class VenuesController < ApplicationController
  before_filter :find_venue
  helper_method :scope
  
  def find_venue
    @venue =  Venue.find params[:id]
  end
  
  def scope
    params[:scope] || 'upcoming'
  end
  
  def show 
    @events = case scope
      when 'upcoming'
        @venue.events.for_dates_range(Time.now, 1.year.from_now)
      when 'past'
        @venue.events.for_dates_range(1.year.ago, Time.now)        
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
