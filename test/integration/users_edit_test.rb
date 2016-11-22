require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user:{name:"", email:"foo@invalid", password: "foo", password_confirmation:"bar"}
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), user:{name: name, email: email, password: "", password_confirmation: ""}
    # パスワードを変更しないときは、パスワードは空でokという仕様。
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    # データベースから最新のユーザ情報を読み込む。
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
  # このテストではまずeditアクションに行く。
  # editのviesが表示されているかどうかのcheck
  # 名前とメアドに新しい値を代入（これが編集ということ）
  # 送信するデータとしてpatchで送る。
  # flashが表示されているかcheck
  # うまくリダイレクトされているかcheck


end
