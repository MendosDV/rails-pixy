class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :visits, dependent: :destroy

  validates :nickname, :birth_date, presence: true
  has_one_attached :picture
end
