class EventsController < ApplicationController
  def find_category
    @category ||= Category.find(params[:category_id])
  end
  
  def find_genre
    @genre ||= Genre.find(params[:genre_id])
  end
  
  
end
