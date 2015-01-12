class AddPropertiesToUserArticles < ActiveRecord::Migration
  def change
    add_column :user_articles, :hidden, :boolean
    add_column :user_articles, :clicked, :boolean
  end
end
