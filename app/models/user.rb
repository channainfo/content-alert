class User < ActiveRecord::Base
  has_secure_password(validations: false)

  # password must be present within 6..72
  validates :password, presence: true, on: :create
  validates :password, length: { in: 6..72}, on: :create
  validates :password, confirmation: true

  # email must be in a valid format and has unique value if it is being provided
  validates :email, email: true
  validates :email, uniqueness: true
  validates :email, email: {message: 'invalid format'}

  validates :phone, uniqueness: true, if: ->(u) { u.phone.present? }

  validates :full_name, presence: true

  ROLE_ADMIN  = 'Admin'
  ROLE_NORMAL = 'Normal'

  before_save :normalize_attrs
  before_create :generate_attrs

  attr_accessor :old_password

  def generate_attrs
    self.role = User::ROLE_NORMAL unless self.role.present?
    generate_token_for(:auth_token)
    generate_token_for(:confirmed_token)
  end

  def generate_token_for(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def normalize_attrs
    self.email.downcase!
  end

  def self.authenticate(email, password)
    login_email = email.blank? ? '' : email.downcase
    user = User.find_by!(email: login_email)
    user.authenticate(password)
  rescue ActiveRecord::RecordNotFound
    false
  end

  def change_password old_password, new_password, confirm
    if self.authenticate(old_password)
      self.password = new_password
      self.password_confirmation = confirm

      save
    else
      errors.add(:old_password, 'does not matched')
      false
    end
  end

  def self.visible_roles
    [ROLE_NORMAL, ROLE_ADMIN]
  end

  def is_admin?
    role == User::ROLE_ADMIN
  end

end
