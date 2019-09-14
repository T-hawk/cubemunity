class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true
  validates :user_id, presence: true
  validates_presence_of :title, :content, :user_id

  belongs_to :user
end
