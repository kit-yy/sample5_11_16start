class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end

# マイグレーションファイルは、changeメソッドの集合。
# create_tableは、テーブルをデータベースに作成するメソッド。
# Usersのデータベースは、id,name,email,created_at,updated_atのカラムを持つ。

# rake db:migrateをすると、db/development.sqlite3ができる。
# これにデータベース保存されている。SQliteデータベース。
# 