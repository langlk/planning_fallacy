class Account < ActiveRecord::Base
  belongs_to :user
  has_many :checkins

  validates_presence_of :user, :access_token, :refresh_token, :expires_in

  def lateness
    if self.checkins.any?
      total = self.checkins.reduce(0) { |sum, checkin| sum + checkin.lateness }
      return total / self.checkins.length
    else
      return 0
    end
  end

  def earliness
    -self.lateness
  end

  def late?
    self.lateness > 0
  end
end
