class Checkin < ActiveRecord::Base
  belongs_to :account
  validates_presence_of :account, :event_time, :lateness, :name
end
