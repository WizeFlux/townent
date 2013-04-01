class CitiesController < ApplicationController
  def index
    @countries = Country.all
  end
end
