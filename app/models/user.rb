class User < ActiveRecord::Base
  has_many :feeds, dependent: :destroy
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
end
