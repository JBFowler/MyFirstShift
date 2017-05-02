class Unit < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :organization
  has_many :invites, dependent: :destroy
  has_many :users, dependent: :destroy

  def to_param
    location
  end

end
