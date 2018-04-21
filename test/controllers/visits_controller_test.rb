require 'test_helper'

class VisitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @visit = visits(:one)
  end

  test "should get index" do
    get visits_url
    assert_response :success
  end

  test "should get new" do
    get new_visit_url
    assert_response :success
  end

  test "should create visit" do
    assert_difference('Visit.count') do
      post visits_url, params: { visit: { date: @visit.date, infection_injury: @visit.infection_injury, patient_id: @visit.patient_id, special_observations: @visit.special_observations, visit_description: @visit.visit_description } }
    end

    assert_redirected_to visit_url(Visit.last)
  end

  test "should show visit" do
    get visit_url(@visit)
    assert_response :success
  end

  test "should get edit" do
    get edit_visit_url(@visit)
    assert_response :success
  end

  test "should update visit" do
    patch visit_url(@visit), params: { visit: { date: @visit.date, infection_injury: @visit.infection_injury, patient_id: @visit.patient_id, special_observations: @visit.special_observations, visit_description: @visit.visit_description } }
    assert_redirected_to visit_url(@visit)
  end

  test "should destroy visit" do
    assert_difference('Visit.count', -1) do
      delete visit_url(@visit)
    end

    assert_redirected_to visits_url
  end
end
