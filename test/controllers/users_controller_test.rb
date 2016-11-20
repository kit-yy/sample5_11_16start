require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "should get newww" do
    get :new
    assert_response :success
  end
  # このテストは、getでnewアクションにアクセスすることから始まる。

end
