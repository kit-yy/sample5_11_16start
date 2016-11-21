module SessionsHelper

    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    # 現在ログインしているユーザを返す。

   
    # ユーザーがログインしていればtrue、その他ならfalseを返す
    def logged_in?
        !current_user.nil?
    end
end



# session[:user_id] = user.id
# と記すだけで、「ユーザのブラウザ内の『一時cookies』に自動的に暗号化済みのユーザIDが作成される。」
# それを一つの関数にすることで簡潔にまとめる。