module SessionsHelper

    def log_in(user)
        session[:user_id] = user.id
    end

    def remember(user)
        user.remember
        # ユーザを永続的セッションで使用できるようにデータベースに保存。user.rbで定義。
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
        # ユーザIDと永続的記憶トークンはペアで使用する。
        # 両方とも、cookiesメソッドを使用する。
        # cookiesメソッドは、『時間指定のできるsessionメソッド』であり、
        # 普通に時間指定もできるが、永久とするときだけ例外的に
        # その時間指定をpermanentチェインすることで永久と指定できる。s
    end


    def current_user?(user)
        user == current_user
    end # ただのリファクタリング用。


# current_userメソッドでも、一時セッションだけでなく永続的セッションも対応させる。
    def current_user
        if (user_id = session[:user_id])
            # 一時セッションがあったら、@current_userを作るor更新する。
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
             # 永続的セッションがあったら(暗号化済みの)
            user = User.find_by(id: user_id)
            # その永続的セッションのユーザIDを持つユーザを見つける。
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
                 # @current_userを更新する。
            end
        end
    end

    def forget(user) # rememberメソッドの逆をする。
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
        # ユーザIDと記憶トークンはペアなので。
    end

   
    # ユーザーがログインしていればtrue、その他ならfalseを返す
    def logged_in?
        !current_user.nil?
    end

    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end

    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end

    def store_location
        session[:forwarding_url] = request.url if request.get?
    end

end



# session[:user_id] = user.id
# と記すだけで、「ユーザのブラウザ内の『一時cookies』に自動的に暗号化済みのユーザIDが作成される。」
# それを一つの関数にすることで簡潔にまとめる。