class Auction < ApplicationRecord
  belongs_to :user
  has_many :bids, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user


 def liked_by?(user)
     likes.exists?(user: user)
 end

 def like_for(user)
     likes.find_by(user: user)
 end

  include AASM

  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published
    state :cancelled
    state :won
    state :reserve_not_met
    state :reserve_met

    event :publish do
      transitions from: :draft, to: :published
    end

    event :win do
      transitions from: :published, to: :won
    end

    event :cancel do
      transitions from: [:draft, :published, :won], to: :cancelled
    end

    event :meet_reserve do
      transitions from: :published, to: :reserve_met
    end
  end

end
