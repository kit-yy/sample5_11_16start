class SessionsController < ApplicationController
 
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    if user && user.authenticate(params[:session][:password])
      
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
  end

end
