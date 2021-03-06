class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: VALID_EMAIL_REGEX

  before_validation :downcase_email

  has_many :auctions, dependent: :destroy
  has_many :bids, dependent: :destroy

   has_many :likes, dependent: :destroy
   has_many :liked_auctions, through: :likes, source: :auction




  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def downcase_email
    self.email.downcase! if email.present?
  end


end
