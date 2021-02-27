require './boat'

### DIRECTIONS
# E  = 0.00000
# NE = 0.78539
# N  = 1.57080
# NW = 2.35619
# W  = 3.14159
# SW = 3.92699
# S  = 4.71239
# SE = 5.49779

wv = 10
rw_degrees = 361
boat = Boat.new(rw_degrees, wv)
puts "Wind Speed:\n#{wv}"
puts "Real Wind Angle in Degrees:\n#{rw_degrees}"
puts "Boat Speed:\n#{boat.velocity}"
