class CreateUserArticles < ActiveRecord::Migration
  def change
    create_table :user_articles do |t|
      t.references :user, index: true
      t.references :article, index: true
      t.references :subscription, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_articles, :users
    add_foreign_key :user_articles, :articles
    add_foreign_key :user_articles, :subscriptions
  end
end