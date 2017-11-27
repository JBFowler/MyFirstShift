class Manager < ActiveRecord::Base
  mount_uploader :picture, PictureUploader

  belongs_to :organization
  belongs_to :unit, optional: true

  validates_presence_of(:name, :description)
end
