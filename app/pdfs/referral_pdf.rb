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
class ReferralPdf < Prawn::Document

	def initialize(hospital_referral, patient, user_name, user_clinic, user_email, ward)
		super(top_margin: 120) #Override to edit margin

		@hospital_referral = hospital_referral #Save parameters as instance variables
		@patient = patient
		@user_name = user_name
		@user_clinic = user_clinic
		@user_email = user_email

		image "app/assets/images/hse_logo.png", :at => [0,710], :width => 200
		image "app/assets/images/customLogo.png", :at => [440,720], :width => 80

		text"Hospital Referral" , size: 15, style: :bold_italic, :align => :center
		text "_____________________________________________ 

		", :align => :center

		text " #{Date.parse(hospital_referral.date).strftime("%d-%m-%Y")}
		", size: 11, style: :bold_italic
		text "To whom it may concern, \n\n I, #{user_name} am referring patient #{patient.name} to #{hospital_referral.hospital_name} for further medical attention. 
		\n #{patient.name} has been referred due to #{hospital_referral.referral_reason}. \n
		 It is recommended that they are assigned a specialist in the #{hospital_referral.department} department.
		 ",size: 11
		text "Full Referral Details are as follows: \n\n", size: 11, style: :bold_italic, :bottom_margin =>10

		text "Patient Name: #{hospital_referral.patient_name}", size: 11, style: :italic
		text "Hospital Referred To: #{hospital_referral.hospital_name}",size: 11, style: :italic
		text "Reason: #{hospital_referral.referral_reason}",size: 11, style: :italic
		text "Recommended Department: #{hospital_referral.department} \n\n",size: 11, style: :italic

		text "#{ward}",size: 11, style: :bold #Prints the ward 

		text "\nFull Patient Details:", size: 11, style: :bold_italic, :bottom_margin =>10
		table ([
			["Patient Name","Dob","Address","Phone","Allergy/Condition"] , 
			["#{patient.name}","#{patient.dob}","#{patient.address}","#{patient.phone}","#{patient.allergy_condition}"]
			]), width: bounds.width



		text "\n\n If there are any queries please do not hesitate to contact the undersigned."
		text "


		___________________________",size: 11, style: :italic

		 text "#{user_name} 
		 #{user_clinic}",size: 10, style: :italic

	end

end #End of Class
