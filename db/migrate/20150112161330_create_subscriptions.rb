class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true
      t.references :feed, index: true

      t.timestamps null: false
    end
    add_foreign_key :subscriptions, :users
    add_foreign_key :subscriptions, :feeds
  end
end
