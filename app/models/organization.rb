class Organization < ActiveRecord::Base
  validates_presence_of(:name, :size, :sector, :subdomain)
  validates :name, length: { in: 4..30 }
  validates :subdomain, length: { in: 4..20 }
  validates :subdomain, format: { with: /\A[a-z0-9]+\z/, message: 'must be all lowercase and include only letters and numbers' }

  has_many :users, inverse_of: :organization
  accepts_nested_attributes_for :users
end