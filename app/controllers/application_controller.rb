class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_city
  # before_filter :log_request_location
  
  # def log_request_location
  #   logger.info request.location.inspect
  # end
end
