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

  def past_years_new_members
    new_members = []
    12.times do |n|
      new_members << cached_new_members_by_month(n.months.ago.month).count
    end
    return new_members.reverse
  end

  #Need to setup redis for caching
  def cached_new_members_by_month(month)
    Rails.cache.fetch([self.class.name, month, :new_member], expires_in: 240.hours) { members.new_members_this_month(month).to_a }
  end
end
