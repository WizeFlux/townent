class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_city
  
  def current_city
    if session[:city_id]
      City.find session[:city_id]
    else
      redirect_to(cities_url)
    end
  end
end
