require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do
    get signup_path

    assert_no_difference 'User.count' do
      post users_path, user:{ name:"",email:"user@invalid", password:"foo", password_confirmation:"bar"}
    end

    assert_template 'users/new'
  
  end
    # 今回は、ユーザの登録の一連のテストなので、
    # まずはsignup_path(ユーザ登録ページ)にアクセス。


  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name:  "Example User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
    assert_template 'users/show'
    assert is_logged_in?
  end
  # post_via_redirectメソッドは、POSTリクエスト送信結果を見た後に、
  # 指定されたURLにリダイレクトするメソッド。

  # asset_template : viewがうまく表示されるかどうかのアサーション

  # assert is_logged_in? : ログインするかどうかのテスト。
  # ここでは、サインイン直後のことをチェックする。

end
