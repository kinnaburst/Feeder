class AddNameToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :name, :string
  end
end
