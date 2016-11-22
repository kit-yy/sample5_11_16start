module UsersHelper
    # デフォルトでは、
    # ヘルパーファイルで定義したメソッドは、
    # 自動的にすべての『view』で使用できる。

    # 引数で与えられたユーザーのGravatar画像を返す

  def gravatar_for(user, options = {size:80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
    # gravatarのURLでは、MD5ハッシュでユーザのメアドをハッシュ化している。
    # Digestライブラリのhexdigestメソッドを使用すると、
    # MD5ハッシュアルゴリズムが使用できる。

end
