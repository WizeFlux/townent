class EventGroupsController < ApplicationController
  before_filter :find_resource, :find_parent_resource, :find_grand_parent_resource
  
  def find_resource
    @event_group ||= EventGroup.find params[:id]
  end
  
  def find_grand_parent_resource
    @genre ||= Genre.find params[:genre_id]
  end
  
  def find_parent_resource
    @category ||= Category.find params[:category_id]
  end
end
