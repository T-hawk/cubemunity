class User < ApplicationRecord
  attr_accessor :remember_token, :remember_me

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }, format: { with:  VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates_presence_of :username, :email, :password

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  def remember
    update_attribute(:remember_token, SecureRandom.uuid)
  end

  def forget
    update_attribute(:remember_token, nil)
  end
end
