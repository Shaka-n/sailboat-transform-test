class Calculation
    attr_accessor :variance, :eta
  
    def initialize
      @variance = 0
      @eta = 0.01
    end
  
    def determine_apparent_wind_angle(true_wind_angle, wind_velocity)
      equation_1 = wind_velocity * @eta
      maybe_apparent_wind_angle = true_wind_angle - 0.0001
      true_wind_radians = true_wind_angle * Math::PI/180
  
      until @variance > equation_1 - 0.001 && @variance < equation_1 + 0.001
        equation_2 = sailboat_transform(true_wind_radians, maybe_apparent_wind_angle)
  
        maybe_apparent_wind_angle -= 0.00001
        @variance = equation_1 - equation_2
      end
  
      maybe_apparent_wind_angle * 180 / Math::PI
    end
  
    def sailboat_transform(true_wind_angle, apparent_wind_angle)
      Math.sin(true_wind_angle) * Math.sin(apparent_wind_angle) * (
        Math.sin(apparent_wind_angle / 2) /
        Math.sin(true_wind_angle - apparent_wind_angle)
      ) ** 2
    end
  end

  boat_calc = Calculation.new

  true_wind_angle = 1
  wind_velocity = 10

apparent_wind_angle = boat_calc.determine_apparent_wind_angle(true_wind_angle, wind_velocity)

  puts 10 * ( Math.sin(1.5708 - apparent_wind_angle) / Math.sin(apparent_wind_angle) ).abs() 