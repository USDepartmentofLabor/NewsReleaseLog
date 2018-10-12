class User
  include Mongoid::Document
  include Mongoid::Timestamps
  extend Enumerize

  
  # Include default devise modules. Others available are:
  # :confirmable,  :timeoutable and :omniauthable,:registerable,
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :first_name,         type: String, default: ""
  field :last_name,         type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  field :failed_attempts, type: Integer, default: 3 # Only if lock strategy is :failed_attempts
  field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  field :locked_at,       type: Time
  field :role
  enumerize :role, in: [:user, :moderator, :admin], default: :user

  # Associations
  has_many :news_logs

  validates_presence_of :first_name,:last_name
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_presence_of :password, :password_confirmation
  attr_accessor :skip_password_validation

  def initials
    first_name[0,1]+last_name[0,1] || "Unknown"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def password_required?
    return false if skip_password_validation
    super
  end

end
