require "rails_helper"

describe Checkin do
  it { should belong_to :user }
  it { should validate_presence_of :user }
  it { should validate_presence_of :event_time }
  it { should validate_presence_of :name }
  it { should validate_presence_of :lateness }
end
