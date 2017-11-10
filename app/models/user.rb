class User < ActiveRecord::Base
  acts_as_paranoid

  #NEED TO CHECK ABOUT VALIDATIONS!!!!!!

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, request_keys: [:subdomain]

  validates_presence_of :first_name, :last_name, :email
  validates_presence_of :employee_type, if: :persisted?
  validates_presence_of :phone, if: :persisted?
  # validates_format_of     :email, with: email_regexp, allow_blank: true, if: :email_changed?
  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  # validates_length_of       :password, within: password_length, allow_blank: true

  belongs_to :organization#, inverse_of: :users
  belongs_to :unit, optional: true

  scope :owners, -> { where role: 'owner' }
  scope :active, -> { where progress: 'complete' }
  scope :ready_to_schedule, -> { where scheduled: false }
  scope :month_groups, -> (date) { where('created_at > ?', date).group_by { |user| user.created_at.beginning_of_month } }

  def self.find_for_authentication(warden_conditions)
    where(:email => warden_conditions[:email], :subdomain => warden_conditions[:subdomain]).first
  end

  def complete!
    self.progress = "complete"
    self.save #consider update_column(:progress, 'complete')
  end

  def full_name
    return "#{first_name} #{last_name}" unless first_name.blank? && last_name.blank?
    "Unknown"
  end

  def owner?
    role == "owner"
  end

  def progress_complete?
    progress == "complete"
  end

  protected

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  # module ClassMethods
  #   Devise::Models.config(self, :email_regexp, :password_length)
  # end
end
