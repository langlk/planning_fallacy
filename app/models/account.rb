class Account < ActiveRecord::Base
  belongs_to :user
  has_many :checkins
  
  validates_presence_of :user, :access_token, :id_token, :refresh_token, :expires_in
end
