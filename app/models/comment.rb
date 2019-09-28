class Comment < ApplicationRecord
  validates :content, presence: true
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates_presence_of :content

  belongs_to :user
  belongs_to :post
end
