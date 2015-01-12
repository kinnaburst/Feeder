class Article < ActiveRecord::Base
	belongs_to :feed
  has_many :users, through: :user_articles
end
