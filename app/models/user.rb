class User < ActiveRecord::Base
  has_secure_password
  has_secure_token
  has_one :account

  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email

  before_destroy :remove_account

  def remove_account
    self.account.destroy
  end

  def invalidate_token
    self.update_columns(token: nil)
  end

  def self.valid_login?(email, password)
    user = find_by(email: email)
    if user && user.authenticate(password)
      user
    end
  end
end
