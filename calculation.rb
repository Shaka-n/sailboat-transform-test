class Calculation
  attr_accessor :variance, :eta

  def initialize
    @variance = 0
    @eta = 1
  end

  def determine_apparent_wind_radians(true_wind_radians, wind_velocity)
    equation_1 = wind_velocity * @eta
    maybe_apparent_wind_radians = true_wind_radians - 0.0001

    until @variance > equation_1 - 0.001 && @variance < equation_1 + 0.001
      equation_2 = sailboat_transform(true_wind_radians, maybe_apparent_wind_radians)

      maybe_apparent_wind_radians -= 0.00001
      @variance = equation_1 - equation_2
    end

    maybe_apparent_wind_radians
  end

  def sailboat_transform(true_wind_radians, apparent_wind_radians)
    Math.sin(true_wind_radians) * Math.sin(apparent_wind_radians) * (
      Math.sin(apparent_wind_radians / 2) /
        Math.sin(true_wind_radians - apparent_wind_radians)
    ) ** 2
  end
end

class Numeric
  def to_radians
    # degrees to radians, where +self+ is the degree
    self * Math::PI / 180
  end

  def to_degrees
    # radians to degrees, where +self+ is the radian
    self * 180 / Math::PI
  end
end

real_wind_degrees = 45
wind_velocity = 10

calculator = Calculation.new

puts "real wind angle"
puts real_wind_degrees

puts "wind velocity"
puts wind_velocity

puts "apparent wind angle"
apparent_wind_radians = calculator.determine_apparent_wind_radians(
  real_wind_degrees.to_radians,
  wind_velocity
)
puts apparent_wind_radians.to_degrees

puts "boat speed"
puts(wind_velocity * Math.sin(real_wind_degrees.to_radians - apparent_wind_radians).to_degrees /
    apparent_wind_radians.to_degrees)
