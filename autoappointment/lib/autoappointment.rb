require "autoappointment/version"

module Autoappointment
 def self.generate(prescription) #Method titled check to estimate which ward the patient should be allocated
      #Save parameters as instance variables
    @prescription = prescription
   	@follow_up = @prescription.follow_up
    #Auto Generate Appointment based on prescription
    #Adding Records From: https://stackoverflow.com/questions/12490076/rails-3-how-to-insert-record-in-database-using-rails
    #Adding Days to Date From: https://stackoverflow.com/questions/4654457/how-to-add-10-days-to-current-time-in-rails
    #Checking a day via Date From: https://stackoverflow.com/questions/11914422/ruby-check-if-date-is-a-weekend

	#If follow up is True, create new record and return True
    if @follow_up == "True" 
	    @duration = @prescription.duration
	    @prescription_date = @prescription.date
	    @new_visit_date = Date.parse(@prescription_date) + @duration #Get date and add the duration i.e. 7 days 

		#Check if the new appointment day is a weekend, if so re-schedule for the following Monday
	    if @new_visit_date.saturday? 
	    	@new_visit_date = @new_visit_date +2 # If Saturday (True), add 2 days to the orignally scheduled date

	    elsif @new_visit_date.sunday?
	    	@new_visit_date = @new_visit_date +1 #If Sunday (True), add 1 day to the originally scheduled date
	    else
	    	#Do nothing 
	    end

	    @new_visit_date_as_string = @new_visit_date.to_s #Parse date back into string before for Database Entry
	    @patient_name = @prescription.patient_name #Get name to search for below

	    @time = "09:30 AM" #Default time
	    @visited = "False" # Set visited to False for Appointment Record
    	@appointment = Appointment.new(:date => @new_visit_date_as_string, :time =>@time, :patient => @patient_name, :visited =>@visited) #Create the Appointment using prescription parameters
     	@appointment.save
    	@result = "True" #Set return statement to true
   
    else
    	@result = "False" #Return False if follow_up is False
    end

    return @result #Return value from Gem back to Controller 

 end
end