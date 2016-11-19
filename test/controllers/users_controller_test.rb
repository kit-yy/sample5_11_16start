require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new　
    # このテストはまず、newアクションからスタートする。
    assert_response :success
  end

end
