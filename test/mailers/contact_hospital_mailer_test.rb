require 'test_helper'

class ContactHospitalMailerTest < ActionMailer::TestCase
  test "hospital_request" do
    mail = ContactHospitalMailer.hospital_request
    assert_equal "Hospital request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
