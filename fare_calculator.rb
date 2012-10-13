class FareCalculator
  attr_accessor :passengers
  attr_accessor :base_charge
  def initialize price_classes
    @price_classes = price_classes
    @passengers = 1
    @base_charge = 0
  end
  
  def calculate distance
      if(passengers<=0) 
        return 0 
      end
      price_class = @price_classes[@passengers]
      (price_class * distance) + @base_charge
  end
  
  
end