# This Numeric patch adds 2 methods that allow us to more easily perform
# unit conversion from radians to degrees, and vice versa.

class Numeric
  # degrees to radians, where +self+ is the degree
  def to_radians
    self * Math::PI / 180
  end

  # radians to degrees, where +self+ is the radian
  def to_degrees
    self * 180 / Math::PI
  end
end
