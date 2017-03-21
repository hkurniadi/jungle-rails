class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  private

  def self.authenticate_with_credentials(email, password)
    @user = User.find_by(email: email.strip.downcase).try(:authenticate, password) || nil
    @user
  end

end
