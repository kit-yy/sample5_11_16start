class User < ActiveRecord::Base

    before_save {self.email = email.downcase}
    # emailをまず最初に小文字にする。
    # before_saveコールバックメソッド。
    # コールバックとは、ActiveRecordに備わっているメソッドのこと。

    validates(:name, presence: true, length:{maximum:50})
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates(:email, presence: true, length:{maximum:255}, format:{with: VALID_EMAIL_REGEX}, uniqueness:{case_sensitive: false})

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