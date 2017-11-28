class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :full_name, use: :slugged

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

  after_commit :flush_new_member_cache

  scope :active, -> { where progress: 'complete' }
  scope :eight_per_hour, -> { where wage: 8 }
  scope :need_verification, -> { where('state_verified = ? OR e_verified = ?', false, false) }
  scope :new_members_this_month, -> (month) { where('extract(month from created_at) = ?', month) }
  scope :owners, -> { where role: 'owner' }
  scope :ready_to_schedule, -> { active.where scheduled: false }
  scope :ten_per_hour, -> { where wage: 10 }

  def self.find_for_authentication(warden_conditions)
    where(:email => warden_conditions[:email], :subdomain => warden_conditions[:subdomain]).first
  end

  def complete!
    update_column(:progress, "Complete")
    true
  end

  def full_name
    return "#{first_name} #{last_name}" unless first_name.blank? && last_name.blank?
    "Unknown"
  end

  def owner?
    role == "owner"
  end

  def ready_for_verification?
    !ssn.blank? && !date_of_birth.blank? && ((!drivers_license_number.blank? && !drivers_license_expiration?.blank?) || (!passport_number.blank? && !passport_expiration.blank?))
  end

  def unit_leader?
    role == "unit_leader"
  end

  def progress_complete?
    progress.casecmp("complete") == 0
  end

  def progress_intro?
    progress.casecmp("intro") == 0
  end

  def progress_intro?
    progress.casecmp("paperwork") == 0
  end

  def flush_new_member_cache
    Rails.cache.delete([self.organization.class.name, self.created_at.month, :new_member])
  end

  def join_unit!(unit)
    return false if self.unit == unit
    unit.members << self

    reload if persisted?
    true
  end

  def update_progress(stage)
    return false if stage.nil?

    update_column(:progress, stage)
    true
  end

  protected

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  # module ClassMethods
  #   Devise::Models.config(self, :email_regexp, :password_length)
  # end
end
