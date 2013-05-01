class Admin::CategoriesController < ApplicationController
  before_filter :authenticate_person!
  
  def index
    @categories = Category.all
  end
  
  def update
    @category = Category.find(params[:id])
    @category.update_attributes(params[:category])
  end
end
