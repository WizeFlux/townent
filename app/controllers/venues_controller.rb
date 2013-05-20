class VenuesController < ApplicationController
  before_filter :find_venue
  helper_method :query, :query_scope
  
  def find_venue
    @venue = Venue.find params[:id]
  end
  
  def query
    params[:q] if params[:q]
  end
  
  def query_scope
    query ? query[:scope] : 'upcoming'
  end
  
  def show 
    @events = @venue.events.order_by_date.page(params[:page]).per(20)
    @events = @events.from_date(DateTime.now + 10.hours) if query_scope == 'upcoming'
    @events = @events.to_date(DateTime.now + 10.hours) if query_scope == 'past'
  end
  
  def update
    if @venue.update_attributes(params[:venue])
      redirect_to @venue
    else
      render 'edit'
    end
  end
end
