class AddIndexesToUsersAndArticles < ActiveRecord::Migration
  def change
    add_index :users, :username, unique: true
    add_column :articles, :url, :string
    add_index :articles, :url, unique: true
  end
end
