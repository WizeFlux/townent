class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_city
  before_filter :log_request_location
  
  def current_city
    if session[:city_id]
      City.find session[:city_id]
    else
      redirect_to(cities_url)
    end
  end
  
  def log_request_location
    logger.info request.location.inspect
  end
end
