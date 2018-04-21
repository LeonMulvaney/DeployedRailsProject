require "whichward/version"

module Whichward
 def self.check(num) #Method titled check to estimate which ward the patient should be allocated
 	if num<18 
 		result = "Recommended to visit the Childrens Ward"
 	elsif num>=18 && num<60
 		result = "Recommended to visit the Adults Ward"
 	else
 		result = "Recommended to visit the Senior Citizens Ward"
 	end
 	return result
 end
end
