require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    # getリクエストを送信すれば、
    assert_response :success
    #「成功」になるはず。
    assert_select "title", "Home | Ruby on Rails Tutorial Sample App"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | Ruby on Rails Tutorial Sample App"
    # セレクタ(assert_select)では、特定のHTMLタグが存在するかどうかテストする。
    # 今回は、<title>タグに、Help | ....が存在するかどうかcheckする。
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | Ruby on Rails Tutorial Sample App"
  end

end
