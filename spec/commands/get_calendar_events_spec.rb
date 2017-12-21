require "rails_helper"

describe GetCalendarEvents, vcr: true do
  subject(:context) { described_class.call(account, min_time, max_time) }

  describe '.call' do
    context "when user cannot be authorized" do
      let(:account) { FactoryBot.create(:account) }
      let(:min_time) { 0 }
      let(:max_time) { 24 }

      it "fails" do
        expect(context).to be_failure
      end
    end

    context "when user can be authorized" do
      let(:account) { FactoryBot.create(:account,
        refresh_token: "correct_refresh_token",
        access_token: "correct_access_token",
        expires_in: 3600,
        id_token: nil
      ) }
      let(:max_time) { "2017-12-22T10:35:59-08:00" }
      let(:min_time) { "2017-12-21T10:35:59-08:00" }

      it "succeeds" do
        expect(context).to be_success
      end
    end
  end
end
