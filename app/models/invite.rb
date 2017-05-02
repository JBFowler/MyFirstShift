class Invite < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :organization
  belongs_to :unit, optional: true

  validates_presence_of :email, :expires_at
  validates :email, uniqueness: { scope: :subdomain, message: "has already been sent an invite" }
  validate :expires_at_cannot_be_in_the_past

  before_create :assign_unique_token

  default_scope { where("expires_at > ?", DateTime.current) }

  scope :owners, -> { where role: 'owner' }

  def expires_at_cannot_be_in_the_past
    if expires_at.present? && expires_at < DateTime.current
      errors.add(:expires_at, "can't be in the past")
    end
  end

  def redeem(user)
    self.update_attributes(redeemed_at: DateTime.current, redeemed_by: user.id)
  end

  private

  def assign_unique_token
    self.code = SecureRandom.hex(50)
  end
end
