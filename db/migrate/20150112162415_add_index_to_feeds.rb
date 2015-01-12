class AddIndexToFeeds < ActiveRecord::Migration
  def change
    add_index :feeds, :url, unique: true
  end
end
