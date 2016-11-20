class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :users, :email, unique:true
  end
end

# 連続してsubmitが押された場合に重複するアカウントが生成されるのを防ぐため、
# モデルレベルだけでなく、データベースレベルでも一意性を定義する。
# モデル => ここ！！=>　データベース


# そうするためには、マイグレーションファイルを作成し、
# そのマイグレーションファイルにvalidationを書き込む。
