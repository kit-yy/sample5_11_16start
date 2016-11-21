class User < ActiveRecord::Base

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

    validates(:password, presence:true,length:{minimum:6} )


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