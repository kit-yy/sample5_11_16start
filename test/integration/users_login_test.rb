require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end

  # ログインパスから始める。
  # ログインフォームがちゃんと表示されたかチェック
  # わざと無効なparamsハッシュを送信
  # その後にログインフォームが再表示されているかチェック(renderされているかチェック)。
  # フラッシュメッセージが追加されるかチェック。
  # ホーム画面に一旦移動する。
  # その画面でフラッシュメッセージが表示されていなければOKとする。
