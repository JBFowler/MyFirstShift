class Unit < ActiveRecord::Base
  belongs_to :organization
  has_many :invites
  has_many :users

  def to_param
    location
  end
  
end