require 'test/unit'
require './teil'
# Testcases for Class in the exam in the winter term 2017/2018.
# Author:: Bernd Kahlbrandt
class Component < Teil
end

class TeilTest < Test::Unit::TestCase
  def setup
    @single_bom = Teil.new("Single",181,:black)
    @one_level_bom = Teil.new("Screw",0,:black)
    @handle = Teil.new("Handle",5,:black)
    @one_level_bom.add(@handle)
    @one_level_bom.add(Teil.new("Groove",15,:nickel))
    @ary_of_parts = [ @single_bom]
    @two_level_bom = Teil.new("Screw",0,:black)
    @two_level_bom.add(Teil.new("Handle",5,:black))
    @groove = Teil.new("Groove",15,:nickel)
    @two_level_bom.add(@groove)
    @groove.add(Component.new("component", 5, :red))
  end

  def test_initialize
    assert_equal(:black, @single_bom.color)
    assert_equal("Single", @single_bom.name)
  end

  def test_add
    assert(@one_level_bom.include?(@handle))
    assert(@one_level_bom.include?(Teil.new("Handle",5,:black)))
    assert_raise(ArgumentError){@one_level_bom.add("Ein Teil")}
  end

  def test_remove
    assert_raise(ArgumentError){@two_level_bom.remove(@one_level_bom)}
    @two_level_bom.remove(@groove)
    refute(@two_level_bom.include?(Component.new("component", 5, :red)))
  end
  def test_hash
    part_hash_01 = {:single_bom => @single_bom }
    assert(part_hash_01.has_value?(@single_bom))
    assert(part_hash_01.has_value?(Teil.new("Single",181,:black)))
    part_hash_02 = {@single_bom => :single_bom }
    assert(part_hash_02.has_key?(@single_bom))
    assert(part_hash_02.has_key?(Teil.new("Single",181,:black)))
  end
  def test_each
    assert(@single_bom.each.is_a?(Enumerator))
    assert(@one_level_bom.each.is_a?(Enumerator))
    ary_enumerable = []
    ary_enumerator = []
    @single_bom.each(){|e| ary_enumerable << e}
    @single_bom.each().each{|e| ary_enumerator << e}
    assert_equal(ary_enumerable, ary_enumerator)
    ary_enumerable = []
    ary_enumerator = []
    @one_level_bom.each(){|e| ary_enumerable << e}
    @one_level_bom.each().each{|e| ary_enumerator << e}
    assert_equal(ary_enumerable, ary_enumerator)
  end

  def test_count
    assert_equal(1,@single_bom.count)
    assert_equal(3,@one_level_bom.count)
    assert_equal(4,@two_level_bom.count)
  end

  def test_some_enumerable_methods
    assert(@one_level_bom.any?{|e| e.color == :black})
    refute(@one_level_bom.all?{|e| e.color == :black})
    assert(@one_level_bom.any?{|e| e.color == :nickel})
  end
  def test_eql_hash
    assert_equal(@one_level_bom.hash, Teil.new("Handle",5,:black).hash) if(@one_level_bom.eql?(Teil.new("Handle",5,:black)))
  end
  def test_overrides
    assert(Teil.instance_methods(false).include?(:to_s),build_my_message(:to_s))
    assert(Teil.instance_methods(false).include?(:==),build_my_message(:==))
    assert(Teil.instance_methods(false).include?(:eql?),build_my_message(:eql?))
    assert(Teil.instance_methods(false).include?(:hash),build_my_message(:hash))
    assert(@ary_of_parts.include?(@single_bom))
    assert(@ary_of_parts.include?(Teil.new("Single",181,:black)))
  end
  private
  def build_my_message(msg)
    return "Koennte es sein, das Sie vergessen haben, '#{msg}' zu ueberschreiben?"
  end

end