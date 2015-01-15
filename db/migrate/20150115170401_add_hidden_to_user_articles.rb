class AddHiddenToUserArticles < ActiveRecord::Migration
  def change
    add_column :user_articles, :hidden, :boolean
  end
end
