class FareCalculator
  attr_accessor :passengers
  attr_accessor :base_charge
  def initialize price_classes
    @price_classes = price_classes
    @passengers = 1
    @base_charge = 5.70
  end
  
  def calculate(*args)
    if args.length == 1
      calculate_price args[0]
    else
      set_base_charge args[1]
      calculate_price args[0]
    end
  end
  
  def calculate_price distance
      if(passengers<=0) 
        return 0 
      end
      price_class = @price_classes[@passengers]
      ((price_class * distance) + @base_charge).round 2
  end  
  def set_base_charge time
    if time.wday == 0
      @base_charge = 8.8
    end
  end
end