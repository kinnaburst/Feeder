class AddPublishedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :published, :datetime
  end
end
