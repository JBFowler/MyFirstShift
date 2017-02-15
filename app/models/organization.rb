class Organization < ActiveRecord::Base
  validates_presence_of(:name, :size, :sector, :subdomain)
  # validates :name, :length => { :in => 4..30 }
  # validates :subdomain, :format => { with: /^[a-z0-9]+$/, :message => 'Subdomain must be all lowercase and include only letters and numbers' }, :length => { :in => 4..20 }

  has_many :users, inverse_of: :organization
  accepts_nested_attributes_for :users
end