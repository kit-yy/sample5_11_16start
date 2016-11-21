Rails.application.routes.draw do
  
  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  
  get    'signup'  => 'users#new'
  
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users
end

  # ユーザデータをRESTアーキテクチャで扱う。
  # ＝＞データを作成、表示、更新、削除可能なリソースとして扱うということ！
  # 
  # そうすると、
  # id = 1のユーザを参照するということは、
  # /users/1にgetメソッドでアクセスするということになる！！

                  #　sessionsも、RESTアーキテクチャに寄せていくと、
                  #　他のRESTfulリソースと問おういつ的に理解しやすくなる。
                  # newアクションで、ログインフォーム。
                  # createアクションで、ログイン。など、無理やり寄せていくわけ。

# HTTP標準では、リダイレクト後に完全なURLが要求されるため、
# リダイレクトの時は、_urlを使用する。


# 名前付きルートを定義したい時は、
# get 'help' => 'static_pages#help'と定義すると、
# getリクエストで/helpが送信された際に、static_pagesコントローラのhelpアクションを呼び出してくれる。
