class User < ActiveRecord::Base
  has_secure_password
  has_one :account

  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email

  before_destroy :remove_account

  def remove_account
    self.account.destroy
  end
end
