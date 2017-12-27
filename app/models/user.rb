class User < ApplicationRecord
  has_many :posts
  attr_accessor :remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with:
    VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: {minimum: 6}, presence: true, allow_nil: true

  has_secure_password

  def User.get_token
    SecureRandom.urlsafe_base64
  end

  def User.get_digest(token)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(token, cost: cost)
  end

  def remember_me
    self.remember_token = User.get_token
    update_attribute(:remember_digest, User.get_digest(self.remember_token))
  end

  def forget_me
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
end
