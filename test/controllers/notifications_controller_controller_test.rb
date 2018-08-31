require 'test_helper'

class NotificationsControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get notifications_controller_index_url
    assert_response :success
  end

end
