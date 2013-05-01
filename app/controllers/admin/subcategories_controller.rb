class Admin::SubcategoriesController < ApplicationController
  before_filter :find, except: %w(index create)
  before_filter :authenticate_person!
  
  def index
    @subcategories = Subcategory.all
    @subcategory = Subcategory.new
  end
  
  def create
    @subcategory = Subcategory.create(params[:subcategory])
  end
  
  def update
    @subcategory.update_attributes(params[:subcategory])
  end
  
  def destroy
    @subcategory.destroy
  end
  
  def find
    @subcategory = Subcategory.find(params[:id])
  end
end
