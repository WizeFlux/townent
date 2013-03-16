class StatusController < ApplicationController
  def show
    @jobs = Delayed::Job.all
  end
end
