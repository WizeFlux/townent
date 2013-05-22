module ApplicationHelper
  def class_if(klass, condition)
    klass if condition
  end
  
  def seatwave
    SeatWave
  end
end
