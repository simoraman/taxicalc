require 'date'
class FareCalculator
  attr_accessor :passengers
  attr_accessor :base_charge
  
  def initialize(price_classes, time = DateTime.now)
    @price_classes = price_classes
    @passengers = 1
    @base_charge = 5.70
    @time = time
  end
  
  def calculate(distance)
      set_base_charge
      calculate_price distance
  end
  
  def calculate_price distance
      if(passengers<=0) 
        return 0 
      end
      price_class = @price_classes[@passengers]
      ((price_class * distance) + @base_charge).round 2
  end  
  
  def set_base_charge
    if @time.wday == 0
      @base_charge = 8.8
    end
  end
  
end