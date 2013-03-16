class CategoriesController < ApplicationController
  before_filter :find_resource, :find_parent_resource
  
  def find_parent_resource
    @genre ||= Genre.find params[:genre_id]
  end
  
  def find_resource
    @category ||= Category.find params[:id]
  end
end
