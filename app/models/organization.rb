class Organization < ActiveRecord::Base
  acts_as_paranoid

  validates_presence_of(:name, :size, :sector, :subdomain)
  validates :name, length: { in: 4..30 }
  validates :subdomain, length: { in: 4..20 }
  validates :subdomain, format: { with: /\A[a-z0-9]+\z/, message: 'must be all lowercase and include only letters and numbers' }

  has_many :invites, dependent: :destroy
  has_many :units, dependent: :destroy
  has_many :members, class_name: 'User', dependent: :destroy#, inverse_of: :organization

  def self.search_by_subdomain(search_term)
    return nil if search_term.blank?
    where("subdomain LIKE ?", "%#{search_term}%").first
  end

  def owners
    users.where(role: "owner")
  end
end
