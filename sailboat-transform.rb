# The desired behavior of these function should resemble the following:

# windDirDegrees
# A helper function windDirToRadians accepts a string containing character representing the compass 
# direction from which the real wind is blowing.
# This function will convert the wind's angle compared to the center of the plane in degrees.

# windDirRadians
# A helper function that accepts an int representing the real wind's angle in degress and returns that value in radians using this formula:
# (450 - compassDegrees) % 360 = radiansDegrees
# Source: https://www.wilsonding.com/2018/07/15/converting_compass_degrees_to_radians/#:~:text=As%20you%20can%20see%2C%20compass,%2C%20then%20go%20counter%2Dclockwise.

# Directions should be 
# E = 0rad
# NE = 0.785398rad
# N = 1.5708rad
# NW = 2.35619rad
# W =  3.14159rad
# SW = 3.92699rad
# S = 4.71239rad
# SE = 5.49779rad


# boatVelocity
# This function will accept an int for windVelocity and a string for realWindDir. It will use the apparentWindCalc helper
# function to calculate the apparent wind angle in radians. It will use the windDirRadians helper function and the windDirDegrees
# helper function to produce an angle in radians representing the real wind's angle in radians relative to the boat's prow.
# The function will then complete this formula to calculate the boat's velocity:
#   boatVelocity = windVelocity * (sin(realWindDirRadians - apparenWindDirRadians) / sin( apparentWindDirRadians))
# The function wil then return boat velocity


# travelTime
# This function will take in a boat's velocity and two coordinate points and calculate the time it will take to reach them

def windDirDegrees()

end

def windDirRadians()

end

# apparentWindCalc
# Input windVelocity as an integer and real wind direction as realWindDir in the form of a string representing 
# radians from the boat's bow. For now it inputs as a float. This function will then attempt to iteratively solve this formula: 
# sin(a0) * sin(a) *( sin(a / 2) / sin(a0 - a) )^2 = VW * eta
# Math.sin(realWindDir) * Math.sin(appWindSpeed) * ( Math.sin(appWindSpeed / 2) / Math.sin(realWindDir - appWindSpeed) )**2
# by inputting values for a that start just below a0 until we reach as close to a balanced equation as possible. 
# I think a tolerance should be: result <= VW*eta + 0.01 || result >= VW*eta -0.01
# Once this condition is met, the loop will end and the final value for a will be returned as the apparent wind angle in radians

# Given an angle and a velocity, find the value of "a" that is within 0.1 of the velocity

def apparentWindCalc(realWindDir, windVelocity)
    eta = 0.01
    k1 = windVelocity * eta
    appWindDir = realWindDir - 0.0001
    variance = 0

    until variance > k1 - 0.001 && variance < k1 + 0.001
        variance = k1 - sailboatTransform(realWindDir, windVelocity, appWindDir)   
        # puts "variance", variance
        appWindDir -= 0.00001
    end


    puts appWindDir * 180 / Math::PI
    return appWindDir * 180 / Math::PI
    # puts appWindDir
    # return appWindDir
end

def sailboatTransform(realWindDir, windVelocity, appWindDir)
    vwEta = Math.sin(realWindDir) * Math.sin(appWindDir) * ( Math.sin(appWindDir / 2) / Math.sin(realWindDir - appWindDir) )**2

    return vwEta
end

puts "real wind angle"
puts 1

puts "wind velocity"
puts 10

puts "apparent wind angle"
apparentWindAngle = apparentWindCalc(1.5708, 10)

puts "boat speed"
puts 10 * ( Math.sin(1.5708 - apparentWindAngle) / Math.sin(apparentWindAngle) ).abs() 