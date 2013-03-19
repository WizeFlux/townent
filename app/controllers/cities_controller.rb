class CitiesController < ApplicationController
  def show
    session[:city_id] = params[:id]
    redirect_to events_url
  end
  
  def index
    @countries = Country.all
  end
end
