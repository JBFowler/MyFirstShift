class Unit < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :organization
  has_many :invites, dependent: :destroy
  has_many :members, class_name: 'User', dependent: :destroy
  belongs_to :created_by, foreign_key: 'created_by_user_id', class_name: 'User'

  validates_presence_of :name, :city, :state
  validates_uniqueness_of :name, scope: %i[city state]

  # def to_param
  #   name
  # end

end
