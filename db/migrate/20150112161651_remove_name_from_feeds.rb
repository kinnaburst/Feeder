class RemoveNameFromFeeds < ActiveRecord::Migration
  def change
    remove_column :feeds, :name, :string
  end
end
