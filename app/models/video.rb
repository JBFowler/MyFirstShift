class Video < ActiveRecord::Base
  belongs_to :organization
  belongs_to :unit, optional: true

  validates_presence_of :url, :page

  scope :introduction, -> { where page: 'Introduction' }
  scope :your_first_day, -> { where page: 'Your First Day' }
end
