require "test_helper"

class AdmissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admissions_new_url
    assert_response :success
  end

  test "should get create" do
    get admissions_create_url
    assert_response :success
  end

  test "should get delete" do
    get admissions_delete_url
    assert_response :success
  end
end
