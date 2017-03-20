class User < ActiveRecord::Base
  before_validation :downcase_email

  has_secure_password

  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end

end
