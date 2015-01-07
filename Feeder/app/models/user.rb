class User < ActiveRecord::Base
  has_many :feeds, dependent: :destroy
  has_secure_password
end
