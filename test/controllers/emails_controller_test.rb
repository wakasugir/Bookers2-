require 'test_helper'

class EmailsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get emails_new_url
    assert_response :success
  end

  test "should get show" do
    get emails_show_url
    assert_response :success
  end

end
