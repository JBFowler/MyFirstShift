class Invite < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :organization
  belongs_to :unit, optional: true
  belongs_to :created_by, foreign_key: 'created_by_user_id', class_name: 'User', optional: true
  belongs_to :redeemed_by, foreign_key: 'redeemed_by_user_id', class_name: 'User', optional: true

  validates_presence_of :email, :expires_at
  validate :user_already_exists, on: :create
  validates :email, uniqueness: { scope: :subdomain, message: "has already been sent an invite. Please go to list of invites to resend the invitation." }, if: Proc.new { |invite| invite.errors.blank? }
  validate :expires_at_cannot_be_in_the_past

  before_create :assign_unique_token

  default_scope { where("expires_at > ?", DateTime.current) }

  scope :owners, -> { where role: 'owner' }
  scope :redeemed, -> { where.not redeemed_at: nil }
  scope :unredeemed, -> { where redeemed_at: nil, deleted_at: nil }

  def expires_at_cannot_be_in_the_past
    if expires_at.present? && expires_at < DateTime.current
      errors.add(:expires_at, "can't be in the past")
    end
  end

  def expired?
    expires_at < DateTime.current
  end

  def redeem(user)
    self.update_attributes(redeemed_at: DateTime.current, redeemed_by: user)
  end

  def redeemer
    User.find_by(id: redeemed_by).full_name
  end

  def user_already_exists
    if User.where(organization_id: organization_id, email: email).any?
      errors.add(:base, "The owner of this email has already joined the organization")
    end
  end

  private

  def assign_unique_token
    self.code = SecureRandom.hex(50)
  end
end
