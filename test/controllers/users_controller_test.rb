require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end


  test "should get newww" do
    get :new
    assert_response :success
  end
  # このテストは、getでnewアクションにアクセスすることから始まる。


  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user:{name: @user.name, email:@user.email}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end
  # 別のユーザのプロフィールを編集しようとしたら、ホーム画面にリダイレクト。

  test "should redirect update when log_in_as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: {name: @user.name, email: @user.email}
    assert flash.empty?
    assert_redirected_to root_url
  end
  # 別のユーザのプロフィールを編集しようとしたら、ホーム画面にリダイレクト。


  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_path
  end
  # ログインユーザしかindexページを表示できないテスト。
  # まずindexにいく。
  #このテストの 現段階ではログインしていないため、リダイレクトされるかcheck



  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end


  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

end

