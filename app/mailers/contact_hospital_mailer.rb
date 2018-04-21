class ContactHospitalMailer < ApplicationMailer
	default from: "leonmul96@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_hospital_mailer.hospital_request.subject
  #
  def hospital_request(body,email,subject)
    @data = data
    @user = user
    @subject = subject

    mail to: "leonmul96@gmail.com", subject: "Hospital Referral"
  end

    def mail_method(data,email,subject)
    @body=data
    mail(to: email, subject: subject)
    #redirect_to "patients_path", notice: "Hospital Infromed of Referral"
  end
end
