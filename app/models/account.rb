class UserSession < Authlogic::Session::Base
end

class Account < ActiveRecord::Base
  acts_as_authentic do |c|
    c.perishable_token_valid_for 24*60*60
  end

  attr_accessor :password

  # Validations
  validates_presence_of     :email, :role
  validates_presence_of     :password,                   :if => :password_required
  validates_presence_of     :password_confirmation,      :if => :password_required
  validates_length_of       :password, :within => 4..40, :if => :password_required
  validates_confirmation_of :password,                   :if => :password_required
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :email,    :case_sensitive => false
  validates_format_of       :email,    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_format_of       :role,     :with => /[A-Za-z]/

  # Callbacks
  before_save :generate_password

  ##
  # This method is for authentication purpose
  #
  def self.authenticate(email, password)
    account = first(:conditions => { :email => email }) if email.present?
    account && account.password_clean == password ? account : nil
  end

  ##
  # This method is used for retrive the original password.
  #
  def password_clean
    crypted_password.decrypt(password_salt)
  end

  private
    def generate_password
      return if password.blank?
      self.password_salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
      self.crypted_password = password.encrypt(self.password_salt)
    end

    def password_required
      crypted_password.blank? || !password.blank?
    end
end
