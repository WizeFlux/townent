class GenresController < ApplicationController
  before_filter :find_resource
  
  def find_resource
    @genre ||= Genre.find params[:id]
  end
  
  def show
  end
end
