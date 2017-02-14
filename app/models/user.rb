class User < ActiveRecord::Base
  has_secure_password validations: false

  validates_presence_of(:first_name, :last_name, :email, :password)

  belongs_to :organization
end