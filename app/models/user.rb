class User < ActiveRecord::Base
  has_secure_password
  has_one :account
  has_many :checkins

  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email
end
