class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :feed
      t.string :title
      t.string :author
      t.string :posted
      t.text :snippet
      t.string :link

      t.timestamps null: false
    end
  end
end
