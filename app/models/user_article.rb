class UserArticle < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  belongs_to :subscription
end
