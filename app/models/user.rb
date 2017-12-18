class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :full_name, use: :slugged

  acts_as_paranoid

  #NEED TO CHECK ABOUT VALIDATIONS!!!!!!

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, request_keys: [:subdomain], reset_password_keys: [:email, :subdomain]

  validates_presence_of :first_name, :last_name, :email, :username
  validates_presence_of :employee_type, :phone, :date_of_birth, :ssn, if: :persisted?, unless: :progress_intro?
  validates_presence_of :drivers_license_number, message: "or Passport number can't be blank", if: :persisted?, unless: :passport_number?, unless: :progress_intro?
  validates_presence_of :drivers_license_expiration, if: :drivers_license_number?, unless: :progress_intro?
  validates_presence_of :passport_expiration, if: :passport_number?, unless: :progress_intro?
  validates_presence_of :drivers_license_number, if: :drivers_license_expiration?, unless: :progress_intro?
  validates_presence_of :passport_number, if: :passport_expiration?, unless: :progress_intro?
  # validates_presence_of :phone, if: :persisted?
  validate :phone_format, if: :persisted?, unless: :progress_intro?
  validate :ssn_format, if: :persisted?, unless: :progress_intro?
  # validates_format_of     :email, with: email_regexp, allow_blank: true, if: :email_changed?
  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, within: 8..128, allow_blank: true

  belongs_to :organization#, inverse_of: :users
  belongs_to :unit, optional: true
  has_many :fun_facts, dependent: :destroy

  after_commit :flush_new_member_cache

  scope :active, -> { where progress: 'Complete' }
  scope :e_verified, -> (e_verified) { where e_verified: e_verified }
  scope :eight_per_hour, -> { where wage: 8 }
  scope :employee_type, -> (employee_type) { where employee_type: employee_type }
  scope :need_verification, -> { where('state_verified = ? OR e_verified = ?', false, false) }
  scope :new_members_this_month, -> (month) { where('extract(month from created_at) = ?', month) }
  scope :owners, -> { where role: 'owner' }
  scope :progress, -> (progress) { where progress: progress }
  scope :ready_to_schedule, -> { active.where scheduled: false }
  scope :role, -> (role) { where role: role }
  scope :state_verified, -> (state_verified) { where state_verified: state_verified }
  scope :ten_per_hour, -> { where wage: 10 }

  def self.find_for_authentication(warden_conditions)
    where(:email => warden_conditions[:email], :subdomain => warden_conditions[:subdomain]).first
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    where(conditions).first
  end

  def self.to_csv
    attributes = %w{last_name first_name email username progress employee_type role wage phone ssn e_verified state_verified drivers_license_number drivers_license_expiration passport_number passport_expiration}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
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

  def phone_format
    unless /^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$/.match(phone)
      errors.add(:phone, ": Please enter number as (xxx) xxx-xxxx")
    end
  end

  def ready_for_verification?
    !ssn.blank? && !date_of_birth.blank? && ((!drivers_license_number.blank? && !drivers_license_expiration?.blank?) || (!passport_number.blank? && !passport_expiration.blank?))
  end

  def ssn_format
    unless /^\d{3}-?\d{2}-?\d{4}$/.match(ssn)
      errors.add(:ssn, ": Please enter SSN as XXX-XX-XXXX")
    end
  end

  def unit_leader?
    role == "unit_leader"
  end

  def progress_applications?
    progress.casecmp("applications") == 0
  end

  def progress_complete?
    progress.casecmp("complete") == 0
  end

  def progress_first_day?
    progress.casecmp("first day") == 0
  end

  def progress_intro?
    progress.casecmp("intro") == 0
  end

  def progress_employee_info?
    progress.casecmp("employee info") == 0
  end

  def progress_paperwork?
    progress.casecmp("paperwork") == 0
  end

  def progress_policies?
    progress.casecmp("policies") == 0
  end

  def progress_faqs?
    progress.casecmp("FAQ") == 0
  end

  def flush_new_member_cache
    Rails.cache.delete([self.organization.class.name, self.created_at.month, :new_member])
  end

  def join_unit!(unit)
    return false if self.unit == unit
    self.unit = unit
    self.save(validate: false)

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
