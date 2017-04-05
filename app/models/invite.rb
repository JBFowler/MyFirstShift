class Invite < ActiveRecord::Base
  belongs_to :organization
  belongs_to :unit, optional: true

  validates_presence_of :email
  validates :email, uniqueness: { scope: :subdomain, message: "has already been sent an invite" }

  before_create :assign_unique_token

  def redeem(user)
    self.update_attributes(redeemed_at: DateTime.current, redeemed_by: user.id)
  end

  private

  def assign_unique_token
    self.code = SecureRandom.hex(50)
  end
end
