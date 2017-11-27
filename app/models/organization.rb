class Organization < ActiveRecord::Base
  acts_as_paranoid
  mount_uploader :store_front, StoreFrontUploader

  validates_presence_of(:name, :size, :sector, :subdomain)
  validates :name, length: { in: 4..30 }
  validates :subdomain, length: { in: 4..20 }
  validates :subdomain, format: { with: /\A[a-z0-9]+\z/, message: 'must be all lowercase and include only letters and numbers' }

  has_many :invites, dependent: :destroy
  has_many :units, dependent: :destroy
  has_many :managers, dependent: :destroy
  has_many :members, class_name: 'User', dependent: :destroy#, inverse_of: :organization

  def self.search_by_subdomain(search_term)
    return nil if search_term.blank?
    where("subdomain LIKE ?", "%#{search_term}%").first
  end

  def add_wage(wage)
    wages << wage.to_i
    save
  end

  def owners
    members.where(role: "owner")
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

  def cached_units
    Rails.cache.fetch([self.class.name, self.id, :units], expires_in: 240.hours) { units.order("lower(name) ASC").to_a }
  end
end
