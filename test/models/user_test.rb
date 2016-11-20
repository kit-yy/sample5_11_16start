require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  def setup
    @user = User.new(name:"Example User", email:"user.@example.com")
  end

  # この変数をテストしたい項目のたびに入れ替えて使って行く。

  test "should be valid" do
    assert @user.valid?
  end
  # 特にアクションをすることはないが、そのユーザがvalidであると判定してくれるかが問題

  test "name should be valid" do
    @user.name = ""
    assert_not @user.valid?
  end
  # 特にアクションをすることはないが、そのユーザがvalidかどうかを判定。
  # その際、名前を変えたverの@userを使用する。

  test "email should be valid" do
    @user.email = ""
    assert_not @user.valid?
  end


  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 300
    assert_not @user.valid?
  end

  test "email validation should accept vaild addresses" do
    invalid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not = @user.valid?, "#{invalid_address.inspect} should be valid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
# 一意性のテスト。
# @userが保存してある状態で、@userのコピーがvalidでなければOKの意味。


  test "email addresses should be unique without upcasing" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end


end
