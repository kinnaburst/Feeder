class RemovePropertiesFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :author, :string
    remove_column :articles, :posted, :string
    remove_column :articles, :snippet, :text
    remove_column :articles, :link, :string
  end
end
