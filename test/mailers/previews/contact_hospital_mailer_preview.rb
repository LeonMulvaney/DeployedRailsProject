# Preview all emails at http://localhost:3000/rails/mailers/contact_hospital_mailer
class ContactHospitalMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/contact_hospital_mailer/hospital_request
  def hospital_request
    ContactHospitalMailer.hospital_request
  end

end
