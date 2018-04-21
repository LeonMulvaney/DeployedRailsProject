#Use separate class to reduce clutter - This class inherits from the Prawn gem 
#Resources (Multiple Stackoverflow links) From:

#Primary Resource: 
#http://railscasts.com/episodes/153-pdfs-with-prawn-revised?autoplay=true

#Support Resources:
#https://stackoverflow.com/questions/31409818/generating-a-pdf-with-prawn-and-ruby-on-rails
#https://stackoverflow.com/questions/31910161/how-to-generate-pdf-based-on-search-using-prawn-in-ruby-on-rails

#Issues with table From: https://stackoverflow.com/questions/24455356/rails-prawn-undefined-method-table-for-prawndocument0x007fda2d594a98
#Prawn Tables From: http://prawnpdf.org/prawn-table-manual.pdf
class AppointmentPdf < Prawn::Document

	def initialize(appointments) #Receive @a from the appointments_controller
		super(top_margin: 120) #Override to edit margin
		@appointments = appointments #Create a new instance variable from received params
		image "app/assets/images/hse_logo.png", :at => [0,710], :width => 200
		image "app/assets/images/customLogo.png", :at => [440,720], :width => 80
		text "Appointments Report", style: :italic
		text "Printed: #{Time.now.strftime("%d/%m/%Y")}", style: :italic
		line_items
	end

	def line_items
		move_down 20
		table line_item_rows, width: bounds.width do #Call line_item_rows
			row(0).font_style = :bold #Styling options
			self.header = true
		end
	end

	def line_item_rows #Create 2d array to store headings, loop through values and then display in table
		[["Day","Date","Time","Patient Name","Visited"]] +
	    @appointments.map do |appointment|
	     [ Date.parse(appointment.date).strftime("%A"),Date.parse(appointment.date).strftime("%d/%m/%Y"),appointment.time, appointment.patient, appointment.visited]
	    end
	end

end #End of Class

#@appointments.each do |appointment| #loop through each instance variable and print
#text "#{appointment.date} #{appointment.time} #{appointment.patient} #{appointment.visited}"
#end