class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :profiles, dependent: :destroy
  has_one_attached :avatar

  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true

  acts_as_token_authenticatable

  def self.from_google(user_from_google)
    create_with(uid: user_from_google[:uid], email: user_from_google[:email],
                first_name: user_from_google[:first_name], last_name: user_from_google[:last_name], provider: 'google',
                password: Devise.friendly_token[0, 20]).find_or_create_by!(email: user_from_google[:email])
  end
end
