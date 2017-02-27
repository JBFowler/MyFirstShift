class Invite < ActiveRecord::Base
  belongs_to :organization
  belongs_to :unit, optional: true

  validates_presence_of :email
  
  before_create :assign_unique_token

  private

  def assign_unique_token
    self.code = SecureRandom.hex(50)
  end

  def unique_token?
    self.class.count(:conditions => ["code = ?", code]) == 0
  end
  
end