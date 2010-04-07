class UserSession < Authlogic::Session::Base
end

class Account < ActiveRecord::Base
  acts_as_authentic do |c|
    c.perishable_token_valid_for 24*60*60
    c.validates_length_of_password_field_options =
     {:on => :update, :minimum => 6, :if => :has_no_credentials?}
    c.validates_length_of_password_confirmation_field_options =
     {:on => :update, :minimum => 6, :if => :has_no_credentials?}
  end

  attr_accessor :password

  # Validations
  validates_presence_of     :email, :role
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
  # WTF?!
  #def password_clean
  #  crypted_password.decrypt(password_salt)
  #end

  def active?
    active
  end
  
  def has_no_credentials?
    crypted_password.blank? #&& self.openid_identifier.blank?
  end
  
  def send_activation_email
    Pony.mail(
      :to => self.email,
      :from => "no-reply@domain.tld",
      :subject => "Activate your account",
      :body => "You can activate your account at this link: " +
                "http://domain.tld/activate/#{self.perishable_token}"
    )
  end
  
  def send_password_reset_email
    Pony.mail(
      :to => self.email,
      :from => "no-reply@domain.tld",
      :subject => "Reset your password",
      :body => "We have recieved a request to reset your password. " +
               "If you did not send this request, then please ignore this email.\n\n" +
               "If you did send the request, you may reset your password using the following link: " +
                "http://domain.tld/reset-password/#{self.perishable_token}"
    )
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
