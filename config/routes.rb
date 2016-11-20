Rails.application.routes.draw do
  root             'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup'  => 'users#new'

end


# HTTP標準では、リダイレクト後に完全なURLが要求されるため、
# リダイレクトの時は、_urlを使用する。


# 名前付きルートを定義したい時は、
# get 'help' => 'static_pages#help'と定義すると、
# getリクエストで/helpが送信された際に、static_pagesコントローラのhelpアクションを呼び出してくれる。
