class UsersController < ApplicationController

  before_action :logged_in_user, only:[:edit, :update,:destroy,:index]
  # editとupdateとindexのアクションに入る時は、まず「ログインしてください」から始まる。
  before_action :correct_user, only:[:edit, :update]

  before_action :admin_user,     only: :destroy

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end

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

  def edit
    @user = User.find(params[:id])
    if @user.save
    else
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end


  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    # ここにadmin属性が含まれていないことに注目。


    def logged_in_user
      unless logged_in?
        store_location
        # sessionヘルパーで定義。
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end


    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
      # current_user?()メソッドは、sessionヘルパーで定義。
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
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