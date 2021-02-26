class Calculation
  attr_accessor :variance, :eta

  def initialize
    @variance = 0
    @eta = 0.01
  end

  def determine_apparent_wind_angle(true_wind, wind_velocity)
    true_wind_radians = true_wind.to_radians
    equation_1 = wind_velocity * @eta
    maybe_apparent_wind_radians = true_wind_radians - 0.0001

    until @variance > equation_1 - 0.001 && @variance < equation_1 + 0.001
      equation_2 = sailboat_transform(true_wind_radians, maybe_apparent_wind_radians)

      maybe_apparent_wind_radians -= 0.00001
      @variance = equation_1 - equation_2
    end

    maybe_apparent_wind_radians
  end

  def sailboat_transform(true_wind_angle, apparent_wind_angle)
    Math.sin(true_wind_angle) * Math.sin(apparent_wind_angle) * (
      Math.sin(apparent_wind_angle / 2) /
        Math.sin(true_wind_angle - apparent_wind_angle)
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


calculator = Calculation.new

puts "real wind angle"
puts 1

puts "wind velocity"
puts 10

puts "apparent wind angle"
apparent_wind_radians = calculator.determine_apparent_wind_angle(1, 10)
puts apparent_wind_radians.to_degrees

puts "boat speed"
puts 10 * ((Math.sin(1.to_radians - apparent_wind_radians) / apparent_wind_radians).to_degrees)
