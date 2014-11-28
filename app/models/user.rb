class User < ActiveRecord::Base
  validates :email, presence: true
  validates :password_digest, presence: true
  validates :token, presence: true
  # validates :access_token, uniqueness: true
  # validates :email, uniqueness: true
end
