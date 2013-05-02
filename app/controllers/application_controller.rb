class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :request_coordinates, :request_location, :nearby_cities

  def request_city
    @request_city ||= City.where(geocoded_name: request_location.city, geocoded_country_name: request_location.country).first if request_location
  end

  def request_coordinates
    @request_coordinates ||= [request_location.longitude, request_location.latitude] if request_location
  end

  def request_location
    @request_location ||= request.location || nil
  end

  def nearby_cities
    @nearby_cities ||= City.limit(8).
                            geo_near(@city ? @city.location : request_coordinates).
                            max_distance(1.2).
                            distance_multiplier(6371).
                            spherical
  end
end
