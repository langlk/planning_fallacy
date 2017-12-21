require "rails_helper"

describe Account do
  it { should belong_to :user }
  it { should have_many :checkins }

  it { should validate_presence_of :user }
  it { should validate_presence_of :access_token }
  it { should validate_presence_of :refresh_token }
  it { should validate_presence_of :expires_in }

  describe '#lateness' do
    it "returns 0 if account has no associated checkins" do
      account = FactoryBot.create(:account)
      expect(account.lateness).to eq(0)
    end

    it "returns average lateness of accounts checkins otherwise" do
      checkin1 = FactoryBot.create(:checkin, event_time: Time.now - 5.minute)
      checkin2 = FactoryBot.create(:checkin, account: checkin1.account, event_time: Time.now + 5.minute)
      checkin3 = FactoryBot.create(:checkin, account: checkin1.account, event_time: Time.now - 15.minute)
      expect(checkin3.account.lateness).to be_within(0.01.minute).of(5.minute)
    end
  end

  describe '#earliness' do
    it "returns how early an account is on average" do
      checkin1 = FactoryBot.create(:checkin, event_time: Time.now + 5.minute)
      checkin2 = FactoryBot.create(:checkin, account: checkin1.account, event_time: Time.now - 5.minute)
      checkin3 = FactoryBot.create(:checkin, account: checkin1.account, event_time: Time.now + 15.minute)
      expect(checkin3.account.earliness).to be_within(0.01.minute).of(5.minute)
    end
  end

  describe '#late?' do
    it "returns true if account's average lateness is greater than 0" do
      checkin1 = FactoryBot.create(:checkin, event_time: Time.now - 5.minute)
      expect(checkin1.account.late?).to eq(true)
    end

    it "returns false if account's average lateness is less than 0" do
      checkin1 = FactoryBot.create(:checkin, event_time: Time.now + 1.minute)
      expect(checkin1.account.late?).to eq(false)
    end
  end

  describe '#remove_checkins' do
    it "destroys an account's checkins when account is destroyed" do
      user = FactoryBot.create(:user, name: 'newtest', email: 'new@new.com', password: 'test123', password_confirmation: 'test123')
      account = FactoryBot.create(:account, user: user)
      checkin1 = FactoryBot.create(:checkin)
      checkin2 = FactoryBot.create(:checkin, account: checkin1.account)
      checkin3 = FactoryBot.create(:checkin, account: account)
      checkin2.account.destroy
      expect(Checkin.all).to eq([checkin3])
    end
  end
end
