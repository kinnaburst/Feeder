class Feed < ActiveRecord::Base
	has_many :articles, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true, uniqueness: true
end
