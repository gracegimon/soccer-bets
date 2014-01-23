# Strong parameters that are going to be permitted
# attr_accessible :email, :username, :password, :password_confirmation
class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password
  before_save { self.email = email.downcase }
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :password_confirmation, :on => :create
  validates_presence_of :email, :on => :create
  validates_presence_of :username, :on => :create
  validates :email, uniqueness: true
  validate  :email_regex
  validates :password, length: { minimum: 6 }

  def email_regex
    if email.present? and not email.match(/\A[^@]+@[^@]+\z/)
      errors.add :email, "This is not a valid email format"
    end
  end

  def initialize(attributes = {})
    super # must allow the active record to initialize!
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
