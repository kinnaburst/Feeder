class Feed < ActiveRecord::Base
	has_many :articles, dependent: :destroy
end
