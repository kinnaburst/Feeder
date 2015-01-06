class Feed < ActiveRecord::Base
	has_many :articles
end
