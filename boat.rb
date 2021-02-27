require './numeric_patch'
require './apparent_wind'

# Boat's primary behavior is to evaluate the velocity given the real wind angle and the
# wind velocity.

class Boat

  # @param wind_velocity   [Integer] (W), The wind velocity.
  # @param real_wind_angle [Integer] (R), (degrees) The "true angle" of the incoming wind
  # @see ApparentWind

  def initialize(real_wind_angle, wind_velocity)
    @wind_velocity = wind_velocity
    @real_wind_agl = reflect_angle_over_180(real_wind_angle).to_radians
    @apparent_wind_agl = ApparentWind.new(@real_wind_agl, @wind_velocity).angle
  end

  # B = W * (sin(R - A) / sin(A)),
  # where A is the "apparent angle" (radians) of the wind the boat is producing. Utilizes
  # the above equation in order to determine boat velocity using the given parameters.
  #
  # @return [Float] boat_velocity (B), The resulting boat velocity.
  
  def velocity
    @wind_velocity * Math.sin(
      @real_wind_agl - @apparent_wind_agl
    ) / @apparent_wind_agl
  end

  private

  # @param angle [Integer] (degrees) the angle that should be reflected, if over 180.
  # @note Used in #initialize before being converted to radians.
  #
  # Reflect the real wind angle across an axis from 0 to 180 degrees, if above 180.
  # If an angle is above 180 degrees (e.g. 270) we will reflect it across this axis in order
  # to return 90 degrees, such that wind from its reflected angle behaves the same way.
  # This is an optimization made for accuracy.
  #
  # @return [Integer] The reflected (or untouched) angle.
  
  def reflect_angle_over_180(angle)
    if angle > 180
      180 - (angle - 180)
    else
      angle
    end
  end
end
