class JobsController < ApplicationController
  def index
    @total = Delayed::Job.count
    @jobs = Delayed::Job.where(:attempts.gt => 0)
  end
end
