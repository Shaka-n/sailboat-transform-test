# ApparentWind's primary behavior is to evaluate the apparent wind angle given the real
# wind angle and the wind velocity. This is needed in order to evaluate {Boat#velocity}.
#
# It uses an equation given by Yoav Raz in his paper:
#
# "Sailboat Speed vs. Wind Speed – predicting sailboat's speed at a given wind"
#
# (Catalyst - Journal of the Amateur Yacht Research Society, Number 34, Page 21, April 2009)
# @see https://sites.google.com/site/yoavraz2/sailingboatspeedvs.windspeed

class ApparentWind
  ETA = 1

  # @param real_wind_angle [Float]   (R), (radians) The "real angle" of the incoming wind.
  # @param wind_velocity   [Integer] (V), The wind velocity.
  
  def initialize(real_wind_angle, wind_velocity)
    if real_wind_angle < 0 || real_wind_angle > 360
      raise 'Invalid angle. Angle must be in degree format, between 0 and 360.'
    end
    @variance = 0
    @real_wind_agl = real_wind_angle
    @wind_velocity = wind_velocity
  end

  # sin(R) * sin(A) * (sin(A / 2) / sin(R - A))^2 = V * D,
  # Where D is some element of drag. Due to the depth of the drag equation's dependence on
  # boat shape and size, let's assume it is some modifier represented by the value of 1.
  # Using the above formula, we solve for A by iterating through its possible values
  # until we balance the equation.
  #
  # @note TOLERANCE: variance <= V*D + 0.001 || variance >= 0.001
  # @note ALL ANGLES are processed in RADIANS.
  #
  # @return [Float] apparent_wind_angle (A), The "apparent angle" (in radians)
  #                 of the wind the boat is producing.
  
  def angle
    equation_1 = @wind_velocity * ETA
    apparent_wind_agl = @real_wind_agl - 0.0001

    until @variance > equation_1 - 0.001 && @variance < equation_1 + 0.001
      equation_2 = sailboat_transform(apparent_wind_agl)

      apparent_wind_agl -= 0.00001
      @variance = equation_1 - equation_2
    end
    puts "Apparent Wind Angle:\n#{apparent_wind_agl}"
    apparent_wind_agl
  end

  private

  # (sin(A / 2) / sin(R - A))^2 section of the angle equation.
  #
  # @note Used iteratively by {#angle}.
  # @returns result of (sin(A / 2) / sin(R - A))^2 for a given A.
  
  def sailboat_transform(apparent_wind_agl)
    Math.sin(@real_wind_agl) * Math.sin(apparent_wind_agl) * (
      Math.sin(apparent_wind_agl / 2) /
        Math.sin(@real_wind_agl - apparent_wind_agl)
    ) ** 2
  end
end
