class Checkin < ActiveRecord::Base
  belongs_to :account
  validates_presence_of :account, :event_time, :event_id
  before_create :calculateness

  def calculateness
    if event_time
      self.lateness = Time.now - event_time
    end
  end
end
