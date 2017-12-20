require "rails_helper"

describe Checkin do
  it { should belong_to :account }
  it { should validate_presence_of :account }
  it { should validate_presence_of :event_id }
  it { should validate_presence_of :event_time }

  describe '#calculateness' do
    it "should set the checkin's lateness to the current time minus the event's time" do
      checkin = FactoryBot.create(:checkin, event_time: Time.now - 5.minute)
      expect(checkin.lateness >= 5.minute).to eq(true)
    end
  end
end
