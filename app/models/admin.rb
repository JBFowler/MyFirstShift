class Admin < ApplicationRecord
  acts_as_paranoid

  #NEED TO CHECK ABOUT VALIDATIONS!


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
end
