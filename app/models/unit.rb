class Unit < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  acts_as_paranoid

  belongs_to :organization
  has_many :invites, dependent: :destroy
  has_many :members, class_name: 'User', dependent: :destroy
  belongs_to :created_by, foreign_key: 'created_by_user_id', class_name: 'User', optional: true

  after_commit :flush_units_cache

  validates_presence_of :name, :city, :state
  validates_uniqueness_of :name, scope: %i[city state]

  # def to_param
  #   name
  # end

  def unit_leaders
    members.where(role: "unit_leader")
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

  def flush_units_cache
    Rails.cache.delete([self.organization.class.name, self.organization.id, :units])
  end
end
