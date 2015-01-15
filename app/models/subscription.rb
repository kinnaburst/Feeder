class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed
  has_many :user_articles, dependent: :destroy
end
