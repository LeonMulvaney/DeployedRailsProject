require 'test_helper'

class HospitalReferralsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hospital_referral = hospital_referrals(:one)
  end

  test "should get index" do
    get hospital_referrals_url
    assert_response :success
  end

  test "should get new" do
    get new_hospital_referral_url
    assert_response :success
  end

  test "should create hospital_referral" do
    assert_difference('HospitalReferral.count') do
      post hospital_referrals_url, params: { hospital_referral: { date: @hospital_referral.date, department: @hospital_referral.department, hospital_name: @hospital_referral.hospital_name, patient_name: @hospital_referral.patient_name, referral_reason: @hospital_referral.referral_reason } }
    end

    assert_redirected_to hospital_referral_url(HospitalReferral.last)
  end

  test "should show hospital_referral" do
    get hospital_referral_url(@hospital_referral)
    assert_response :success
  end

  test "should get edit" do
    get edit_hospital_referral_url(@hospital_referral)
    assert_response :success
  end

  test "should update hospital_referral" do
    patch hospital_referral_url(@hospital_referral), params: { hospital_referral: { date: @hospital_referral.date, department: @hospital_referral.department, hospital_name: @hospital_referral.hospital_name, patient_name: @hospital_referral.patient_name, referral_reason: @hospital_referral.referral_reason } }
    assert_redirected_to hospital_referral_url(@hospital_referral)
  end

  test "should destroy hospital_referral" do
    assert_difference('HospitalReferral.count', -1) do
      delete hospital_referral_url(@hospital_referral)
    end

    assert_redirected_to hospital_referrals_url
  end
end
