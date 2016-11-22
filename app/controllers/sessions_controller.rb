class SessionsController < ApplicationController
 
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # ヘルパーで定義。
      redirect_to user
      # redirect_to user == redirect_to userurl(user)
    else
      flash.now[:danger] = 'Invalid email/password comination' 
      # ユーザ登録の時は、ActiveRecordのモデルを使用しているため、
      # 失敗の際のエラーメッセージも搭載済みであったが、
      # sessionでは、ActiveRecordのモデルを使用しないため、
      # デフォルトではエラーメッセージを作ってくれない。
      render 'new'
    end

  end

  # auhenticateメソッドは、認証に失敗した時、falseを返す。

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  # ヘルパーで作ったlog_outメソッドを使用。
end
