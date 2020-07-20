class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { minimum: 5 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 8 }
  
  has_many :check_out_logs
  has_many :books, through: :check_out_logs

  def self.find_or_create_by_omniauth(auth)
    where(email: auth[:info][:email]).first_or_create do |user|
      user.name = auth[:info][:name]
      user.password = SecureRandom.hex
    end
  end
end
