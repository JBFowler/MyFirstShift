class FunFact < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  belongs_to :unit

  validates_presence_of :question, :answer
end
