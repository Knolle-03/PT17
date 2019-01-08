class Teil

  include Enumerable
  attr_reader :name, :length, :color, :parts
  def initialize(name, length, color)
    @name = name
    @length = length
    @color = color
    @parts = [self]
  end

  def add(part)
    if !part.is_a?(Teil) || equal?(part) || part.parts.include?(self)
        raise ArgumentError, "#{part} is not a Teil."
    else
      @parts.push(part)
    end
  end

  def remove(part)
    raise ArgumentError, "#{part} is not a part of #{self}" unless include?(part)

    @parts.delete(part)
  end

  def each(&block)
    @parts.each(&block)
  end

  def ==(other)
    return false if other.nil? || self.class != other.class
    return true if equal?(other)

    [@name, @length, @color, @parts] == [other.name, other.length, other.color, other.parts]
  end

  def eql?(other)
    return false if other.nil? || self.class != other.class
    return true if equal?(other)

    [@name, @length, @color, @parts].eql?([other.name, other.length, other.color, other.parts])
  end

  def hash
    prime = 31
    result = 1
    result = prime + result * (@name.nil? ? 0 : @name.hash)
    result = prime + result * (@length.nil? ? 0 : @length.hash)
    result = prime + result * (@color.nil? ? 0 : @color.hash)
    prime + result * (@parts.nil? ? 0 : @parts.hash)
  end

  def to_s
    "The Teil is named #{@name}"
  end
end

single_bom = Teil.new("Single",181,:black)
one_level_bom = Teil.new("Screw",0,:black)
handle = Teil.new("Handle",5,:black)
one_level_bom.add(handle)

puts one_level_bom.count


