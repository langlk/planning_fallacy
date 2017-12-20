require "rails_helper"

describe Checkin do
  it { should belong_to :account }
  it { should validate_presence_of :account }
  it { should validate_presence_of :event_time }
  it { should validate_presence_of :name }
  it { should validate_presence_of :lateness }
end
