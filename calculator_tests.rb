require_relative "test_helper"
require "test/unit"
require_relative 'fare_calculator'
require_relative 'price_class'
require 'date'
class TestFareCalculator < Test::Unit::TestCase
  def setup
    monday = DateTime.new(2012, 11, 5)
    prices = PriceClass.new({1..2=>1.48, 3..4=>1.78, 5..6=>1.92, 7..10=>2.07})
    @calc = FareCalculator.new prices, monday
    @distance = 5
  end
  
  def test_basic_fare_per_km
    price = @calc.calculate(@distance) 
    assert_in_delta(13.1, price, 0.001)
  end
  
  def test_three_passengers_elevates_price_class
    @calc.passengers = 3
    price = @calc.calculate(@distance)
    assert_equal(14.6, price)
  end
  
  def test_five_passengers_elevates_price_class
    @calc.passengers = 5
    price = @calc.calculate(@distance)
    assert_equal(15.3, price)
  end
  
  def test_base_price_is_added
    price = @calc.calculate(0) 
    assert_in_delta(5.7, price, 0.001)
  end
  
  def test_zero_passengers_zero_price
    @calc.passengers = 0
    price = @calc.calculate(@distance)
    assert_equal(0, price)
  end
  
  def test_result_formatted_with_two_decimals
    @calc.base_charge = 5.71111
    price = @calc.calculate(@distance) 
    assert_in_delta(13.11, price, 0.001)
  end
  
  def test_weekdays_base_charge
    tuesdayAfternoon = DateTime.new(2012, 11, 6, 12,0)
    prices = PriceClass.new({1..2=>1.48, 3..4=>1.78, 5..6=>1.92, 7..10=>2.07})
    @calc = FareCalculator.new prices, tuesdayAfternoon
    @distance = 5
    price = @calc.calculate @distance
    assert_in_delta(13.1, price, 0.001)
  end
  
  def test_base_charge_is_elevated_on_sunday
    sunday = DateTime.new(2012, 11, 4)
    prices = PriceClass.new({1..2=>1.48, 3..4=>1.78, 5..6=>1.92, 7..10=>2.07})
    @calc = FareCalculator.new prices, sunday
    @distance = 5
    
    price = @calc.calculate @distance
    assert_in_delta(16.2, price, 0.001)
    
  end
end

