require "test/unit"
require_relative 'price_class'

class PriceClassTests < Test::Unit::TestCase
  def test_price_classes_are_defined_by_range
    price_class = PriceClass.new({1..2=>1.48, 3..4=>1.78, 5...10=>1.92})
    assert_equal(1.48, price_class[1])
    assert_equal(1.78, price_class[4])
    assert_equal(1.92, price_class[6])
  end
  
end

