class User < ActiveRecord::Base

    attr_accessor :remember_token

    before_save {self.email = email.downcase}
    # emailをまず最初に小文字にする。
    # before_saveコールバックメソッド。
    # コールバックとは、ActiveRecordに備わっているメソッドのこと。

    validates(:name, presence: true, length:{maximum:50})
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates(:email, presence: true, length:{maximum:255}, format:{with: VALID_EMAIL_REGEX}, uniqueness:{case_sensitive: false})


    has_secure_password
    # この文言を加えるだけOK
    # これを有効にするには、passwoed_digestカラムを追加し、
    # gemにハッシュ関数を加える。

    validates(:password, presence:true,length:{minimum:6} , allow_nil:true)
    # allow_nilは、例外処理の方法。


    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    # 引数のハッシュを行う関数。
    # user.ymlの有効なユーザ作成の際に使用する。
    
    # ログイン後の作業に関するテストの時、
    # 仮想ユーザとしてログインしている必要がある。
    # そのためにフィクスチャにテストに必要なデータをtestデータベースに読み込んで置く。
    # その際、パスワードがhas_secure_passwordのbcryptでハッシュ化されたのと同様な要領でハッシュ化してもらうメソッドを使う。
    # 今回それを関数化した。

    # 欠点・・・・
    # ハッシュ化されていない「生のパスワード」が「フィクスチャ」に定義できない。
    # ＝＞
    # テスト用では、全員同じパスワードを使用する。


    # ランダムなトークンを返すメソッド
    def User.new_token
        SecureRandom.urlsafe_base64
    end

# 記憶トークンカラムをusersモデルに入れることで、
# 永続的cookiesを可能にする。

    # 永続的cookiesで使用するユーザをデータベースに記憶する。
    # ユーザを記憶トークンと関連付け、
    # トークンに対応する記憶ダイジェストをデータベースに保存する。
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
    # とりあえずランダムなトークンを作成し、remember_tokenに保存する。
    # 記憶ダイジェストを更新。
        
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    # 渡されたトークンがダジェストと一致したらtrueを返す。
    # BCrypt::Password.new(remember_digest) == remember_tokenの意味。


    def forget
        update_attribute(:remember_digest, nil)
    end
    # ユーザのログインを破棄するメソッド


end

# validates :name, presence: true
# は
# validates(:name, presence: true)
# の
# 意味だったのだ


# uniqueness:{case_sensitive: false}
# は
# uniqueness:trueでありかつ、
# 大文字と小文字を区別しないように設定できる。

# selfを使用しないと、新たにローカル変数を作ってしまう。