class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

end


# getリクエストで、params = {:id = "1"}が送られてくる。
# それを取り出すために、params[:id]と記述する。

# デバッグ(debugメソッド)が役に立つ。
# ＝＞gem byebugを作った。
# ＝＞debuggerを差し込むと、その画面でコンソールのような画面が使えるようになり、
# 　　アプリケーションの現状を確認することができる。