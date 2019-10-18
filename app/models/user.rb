class User < ApplicationRecord
  attr_accessor :remember_token, :remember_me

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }, format: { with:  VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates_presence_of :username, :email, :password

  has_one :personal_bests, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :follows

  has_many :follower_relationships, foreign_key: :following_id, class_name: "Follow"
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :user_id, class_name: "Follow"
  has_many :following, through: :following_relationships, source: :following

  after_save do
    self.create_personal_bests
  end

  def remember
    update_attribute(:remember_token, SecureRandom.uuid)
  end

  def forget
    update_attribute(:remember_token, nil)
  end

  def already_following?(user)
    already_following = false

    user.followers.each do |f|
      if f.id == id
        already_following = true
      end
    end

    already_following
  end
end
