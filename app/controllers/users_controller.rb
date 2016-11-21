class UsersController < ApplicationController


  def new
    @user = User.new
  end
  # 新規登録フォームのためのアクション


  def show
    @user = User.find(params[:id])
  end


  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome!!"
      # ハッシュflashの:successキーに、成功時のメッセージを代入する。
      redirect_to @user
    else
      render 'new'
    end
  end


  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end

# ・ストロングパラメータについて
# params[:id]のように、一つの要素のみ取り出すものなら大丈夫だが、
# params[:user]のように、user(name:"", email:"", ...)というように沢山の要素がある場合、
# httpクライアントからadmin属性などが入れられる可能性があるため危険。

# ・params[:id]とは
# getリクエストで、params = {:id = "1"}が送られてくる。
# それを取り出すために、params[:id]と記述する。

# ・debuggerについて
# デバッグ(debugメソッド)が役に立つ。
# ＝＞gem byebugを作った。
# ＝＞debuggerを差し込むと、その画面でコンソールのような画面が使えるようになり、
# 　　アプリケーションの現状を確認することができる。