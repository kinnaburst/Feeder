class Feed < ActiveRecord::Base
	has_many :articles, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  validates :url, presence: true, uniqueness: true
end
