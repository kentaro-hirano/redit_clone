class Post < ApplicationRecord
  belongs_to :account
  belongs_to :community
  validates_presence_of :title, :account_id, :community_id
end
