class FirstDayItem < ActiveRecord::Base
  belongs_to :organization
  belongs_to :unit, optional: true

  validates_presence_of :title
end
