#
class PowerOfThree

  attr_reader :num
  include Comparable

  def initialize(num)
    raise ArgumentError, 'Parameter has to be an integer!' unless num.is_a?(Integer)

    @num = num
  end

  def value
    3**@num
  end

  def <=>(other)
    return nil if self.class != other.class

    value <=> other.value
  end

  def ==(other)
    return false if other.nil?
    return false if self.class != other.class
    return true if equal?(other)

    value == other.value
  end

  def eql?(other)
    return false if other.nil?
    return false if self.class != other.class
    return true if equal?(other)

    num.eql?(other.num)
  end

  def hash
    31 + @num.hash
  end

  def succ
    PowerOfThree.new(@num + 1)
  end

  def to_s
    "The value is #{value}."
  end

end
