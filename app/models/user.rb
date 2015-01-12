class User < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :feeds, through: :subscriptions
  has_many :user_articles, dependent: :destroy
  has_many :articles, through: :user_articles
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
end
