#Use separate class to reduce clutter - This class inherits from the Prawn gem 
#Resources (Multiple Stackoverflow links) From:

#Primary Resource: 
#http://railscasts.com/episodes/153-pdfs-with-prawn-revised?autoplay=true

#Support Resources:
#https://stackoverflow.com/questions/31409818/generating-a-pdf-with-prawn-and-ruby-on-rails
#https://stackoverflow.com/questions/31910161/how-to-generate-pdf-based-on-search-using-prawn-in-ruby-on-rails

#Issues with table From: https://stackoverflow.com/questions/24455356/rails-prawn-undefined-method-table-for-prawndocument0x007fda2d594a98
#Prawn Tables From: http://prawnpdf.org/prawn-table-manual.pdf

#Prawn Documentation From: http://prawnpdf.org/manual.pdf
#Prawn Text Styling From: http://prawnpdf.org/api-docs/2.0/Prawn/Text.html 
#Prawn Images From: https://stackoverflow.com/questions/23429319/how-to-insert-image-in-pdf-using-prawn
#Prawn PDF Table Manual
class PrescriptionPdf < Prawn::Document

	def initialize(prescription, patient, user_name, user_clinic, user_email)
		super(top_margin: 120) #Override to edit margin

		@prescription = prescription #Save parameters as instance variables
		@patient = patient
		@user_name = user_name
		@user_clinic = user_clinic
		@user_email = user_email

		image "app/assets/images/hse_logo.png", :at => [0,710], :width => 200
		image "app/assets/images/customLogo.png", :at => [440,720], :width => 80

		text"Prescription " , size: 15, style: :bold_italic, :align => :center
		text "_____________________________________________ 

		", :align => :center

		text " #{Date.parse(prescription.date).strftime("%d-%m-%Y")}
		", size: 11, style: :bold_italic
		text "#{patient.name}
		", size: 12, style: :bold_italic
		text "#{patient.address}\n Ph: #{patient.phone}\n Long term Alleries/Conditions: #{patient.allergy_condition}
		", size: 11, style: :italic
		text "_____________________________________________ 
		

		", :align => :center

		text "Prescription Details:", size: 12, style: :bold_italic, :bottom_margin =>10
		table ([
			["Medication","Strength","Frequency","Duration (Days)", "Special Instructions"] , 
			["#{prescription.medication_name}","#{prescription.strength}","#{prescription.frequency}","#{prescription.duration}","#{prescription.special_instructions}"]
			]), width: bounds.width


		text "





		___________________________",size: 11, style: :italic

		 text "#{user_name} 
		 #{user_clinic}",size: 10, style: :italic

	end

end #End of Class
