class Policy < ActiveRecord::Base
  belongs_to :organization
  belongs_to :unit, optional: true
end
