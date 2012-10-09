require "test/unit"
require 'fare_calculator'
require 'price_class'

class TestFareCalculator < Test::Unit::TestCase
  def setup
    prices = PriceClass.new({1..2=>1.48, 3..4=>1.78, 5..6=>1.92, 7..10=>2.07})
    @calc = FareCalculator.new prices
    @distance = 5
  end
  
  def test_basic_fare_per_km
    price = @calc.calculate(@distance) 
    assert_equal(7.4, price)
  end
  
  def test_three_passengers_elevates_price_class
    @calc.passengers = 3
    price = @calc.calculate(@distance)
    assert_equal(8.9, price)
  end
  
  def test_five_passengers_elevates_price_class
    @calc.passengers = 5
    price = @calc.calculate(@distance)
    assert_equal(9.6, price)
  end
  
  def test_base_price_is_added
    @calc.base_charge = 5.7
    price = @calc.calculate(@distance) 
    assert_in_delta(13.1, price, 0.001)
  end
  
end

