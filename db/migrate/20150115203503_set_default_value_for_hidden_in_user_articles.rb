class SetDefaultValueForHiddenInUserArticles < ActiveRecord::Migration
  def change
    change_column :user_articles, :hidden, :boolean, default: false
  end
end
