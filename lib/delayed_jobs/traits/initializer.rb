module Traits::Initializer
  def initialize(parent)
    @parent = parent
    @sw_api = SeatWave.new
  end
  
  def sw_api
    @sw_api
  end
  
  def parent
    @parent
  end
end