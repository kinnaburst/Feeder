class SetDefaultValuesForUserArticles < ActiveRecord::Migration
  def change
    change_column :user_articles, :hidden, :boolean, default: false
    change_column :user_articles, :clicked, :boolean, default: false
  end
end
