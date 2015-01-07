class AddUserIdToFeeds < ActiveRecord::Migration
  def change
    add_reference :feeds, :user, index: true
    add_foreign_key :feeds, :users
  end
end
