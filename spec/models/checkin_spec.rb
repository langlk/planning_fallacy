require "rails_helper"

describe Checkin do
  it { should belong_to :account }
  it { should validate_presence_of :account }
  it { should validate_presence_of :event_id }
  it { should validate_presence_of :event_time }
end
