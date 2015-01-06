class Article < ActiveRecord::Base
	has_one :feed
end
