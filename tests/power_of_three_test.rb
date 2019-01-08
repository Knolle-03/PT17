require 'test/unit'
require './power_of_three'

# Test cases for the class PowerOfThree.
# Author:: Bernd Kahlbrandt
class PowerOfThreeTest < Test::Unit::TestCase
  def setup
    @lb_0 = PowerOfThree.new(0)
    @ub_1 = PowerOfThree.new(1)
    @ub_2= PowerOfThree.new(2)
    @pominus_1 = PowerOfThree.new(1)
    @closed_range_01 = @lb_0..@ub_1
    @closed_range_02 = @lb_0..@ub_2
    @open_range_01 = @lb_0...@ub_2
  end
# Uses '==' to test new created object. may fail, if '==' is not correctly implemented.
  def test_initialize
    assert_equal(1, PowerOfThree.new(0).value)
    assert_equal(1.0/3, PowerOfThree.new(-1).value)
    assert_equal(Rational(1,3), PowerOfThree.new(-1).value)
    assert_equal(1.0/27, PowerOfThree.new(-3).value)
    assert_equal(1.0/81, PowerOfThree.new(-4).value)
    assert_equal(1.0/243, PowerOfThree.new(-5).value)
    assert_equal(3**(-10), PowerOfThree.new(-10).value)
    assert_equal(3**(-20), PowerOfThree.new(-20).value)
  end
# Test some creation tries, that should raise an exception.
  def test_initialize_exception
    assert_raise(ArgumentError){PowerOfThree.new(0.5)}
    assert_raise(ArgumentError){PowerOfThree.new("5")}
    assert_raise(ArgumentError){PowerOfThree.new(Object.new())}
  end
# Rudimentary test, that essentially check if there is a methode 'value'.
  def test_value
    result = @ub_2.value
    result = 3**3
    refute_equal(@ub_2.value, result)
  end
 # Tests the spaceship operator and if it is implemented 
  def test_spaceship
    assert_equal(nil,@sub1 <=> "Hugo")
    assert(PowerOfThree.instance_methods(false).include?(:<=>), build_my_message(:==)) unless(PowerOfThree.included_modules.include?(Comparable))
  end

  def test_ succ
    assert_equal(PowerOfThree.new(0),PowerOfThree.new(0).succ.value)
    assert_equal(PowerOfThree.new(1),PowerOfThree.new(0).succ)
    assert_equal(PowerOfThree.new(0),PowerOfThree.new(-1).succ)
  end
# Tests some essential Range properties.
  def test_range
    assert_equal(2, @closed_range_01.count)
    assert_equal(2, @open_range_01.count)
    refute((PowerOfThree.new(-10)...PowerOfThree.new(2)).include?(Rational(1,2)))
    refute((PowerOfThree.new(-10)...PowerOfThree.new(2)).include?(Rational(1,3)))
    assert_nothing_raised(){(PowerOfThree.new(-10)...PowerOfThree.new(2)).each()}
    assert_equal(2, Range.new(PowerOfThree.new(0),PowerOfThree.new(1)).count())  
  end
# Tests the consistent implementation of some methods, that test for equality.
  def test_equal
    ary = []
    0.upto(9){|n| ary << PowerOfThree.new(n)}
    assert(ary.include?(PowerOfThree.new(5)))
    assert_equal(PowerOfThree.new(5), (PowerOfThree.new(5)))
    assert_equal(nil, PowerOfThree.new(-1)<=> Rational(1,3))
    assert_equal(0,PowerOfThree.new(5)<=>(PowerOfThree.new(5)))
    refute(PowerOfThree.new(5).equal?(PowerOfThree.new(5)))
  end
# Tests the consistent implementation of some methods, that test for equality and hash.

  def test_eql
    hsh = {}
    0.upto(9){|n| hsh[n] = PowerOfThree.new(n)}
    assert(hsh.include?(5))
    assert(hsh.has_key?(5))
    assert(hsh.has_value?(PowerOfThree.new(5)))
    hsh = {}
    0.upto(9){|n| hsh[PowerOfThree.new(n)] = n}
    assert(hsh.include?(PowerOfThree.new(5)))
    assert(hsh.has_key?(PowerOfThree.new(5)))
    assert(hsh.has_value?(5))

  end
# Tests for possibly not overridden methods. Just a hint, may be ok.
  def test_overrides
    assert(PowerOfThree.instance_methods(false).include?(:to_s), build_my_message(:to_s))
    assert(PowerOfThree.instance_methods(false).include?(:==), build_my_message(:==)) unless(PowerOfThree.included_modules.include?(Comparable))
    assert(PowerOfThree.instance_methods(false).include?(:eql?), build_my_message(:eql?))
    assert(PowerOfThree.instance_methods(false).include?(:hash),build_my_message(:hash))
  end
# Helper method to generate messages without much redundancy.
  private
  def build_my_message(msg)
    return "Koennte es sein, das Sie vergessen haben, '#{msg}' zu ueberschreiben?"
  end
end