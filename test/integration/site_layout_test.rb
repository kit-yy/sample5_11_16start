require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "layout links" do
    get root_path
    # 統合テストの最初は、ユーザの一連の作業の流れを見るものなので、
    # まずgetでルートに行く。
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path,count: 2
    assert_select "a[href=?]",help_path
    assert_select "a[href=?]",about_path
    assert_select "a[href=?]",contact_path
    # assert_selctはそのリンクが存在するかどうかを判定するアサーション
  end
end
