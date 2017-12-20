require "rails_helper"

describe Account do
  it { should belong_to :user }
  it { should have_many :checkins }

  it { should validate_presence_of :user }
  it { should validate_presence_of :access_token }
  it { should validate_presence_of :id_token }
  it { should validate_presence_of :refresh_token }
  it { should validate_presence_of :expires_in }

  describe '#lateness' do
    it "returns 0 if account has no associated checkins" do
      account = FactoryBot.create(:account)
      expect(account.lateness).to eq(0)
    end

    it "returns average lateness of accounts checkins otherwise" do
      checkin1 = FactoryBot.create(:checkin, event_time: Time.now - 5.minutes)
      checkin2 = FactoryBot.create(:checkin, account: checkin1.account, event_time: Time.now + 5.minutes)
      checkin3 = FactoryBot.create(:checkin, account: checkin1.account, event_time: Time.now - 15.minutes)
      expect(checkin3.account.lateness).to be_within(0.01.minute).of(5.minute)
    end
  end
end
