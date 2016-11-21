require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup # これで「フィクスチャデータ」を参照する。
    @user = users(:michael)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    get login_path
    post login_path, session:{email:@user.email, password:'password'}
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]",login_path, count:0
    assert_select "a[href=?]",logout_path
    assert_select "a[href=?]",user_path(@user)
  end

end

  # ログインパスから始める。
  # ログインフォームがちゃんと表示されたかチェック
  # わざと無効なparamsハッシュを送信
  # その後にログインフォームが再表示されているかチェック(renderされているかチェック)。
  # フラッシュメッセージが追加されるかチェック。
  # ホーム画面に一旦移動する。
  # その画面でフラッシュメッセージが表示されていなければOKとする。



# このテストではまず、getでログイン用のパスを開く。
# セッション用パスに有効なユーザデータでPOSTする。
# リダイレクト先が正しかチェックする。(assert_redirected_to @user)
# チェックした上で、実際にそのリダイレクトを敢行する。(follow_redirect!)
# その時の画面に、ログインリンクが消えて、ログアウトリンクが表示されていることを確認する。
# プロフィールリンクが表示されていることもチェック。
# assert_selectの、count:0は、そのリンクの個数を記している。
