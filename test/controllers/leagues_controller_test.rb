require "test_helper"

class LeaguesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get leagues_new_url
    assert_response :success
  end

  test "should get create" do
    get leagues_create_url
    assert_response :success
  end

  test "should get edit" do
    get leagues_edit_url
    assert_response :success
  end

  test "should get update" do
    get leagues_update_url
    assert_response :success
  end

  test "should get delete" do
    get leagues_delete_url
    assert_response :success
  end
end
