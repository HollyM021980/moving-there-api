class User < ActiveRecord::Base
  before_create :set_token

  # Auth
  has_secure_password

  # Validations
  validates :email, presence: true
  validates_email_format_of :email

  validates :password_digest, presence: true
  # validates :access_token, uniqueness: true
  # validates :email, uniqueness: true

  #Roles
  enum role: [:admin, :user]


  private
    def set_token
      return if token.present?
      self.token = generate_token
    end

    def generate_token
      SecureRandom.uuid.gsub(/\-/,'')
    end
end
