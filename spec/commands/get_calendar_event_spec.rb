require "rails_helper"

describe GetCalendarEvent, vcr: true do
  subject(:context) { described_class.call(account, event_id) }

  describe '.call' do
    context "when authorization cannot be obtained" do
      let(:event_id) { "7rv3c04d721n2g271suh72gaoj" }
      let(:account) { FactoryBot.create(:account) }

      it "fails" do
        expect(context).to be_failure
      end
    end

    context "when event cannot be found" do
      let(:event_id) { 'incorrect_event_id' }
      let(:account) { FactoryBot.create(:account,
        refresh_token: 'correct_refresh_token',
        access_token: 'correct_access_token',
        expires_in: 3600,
        id_token: nil
        ) }

      it "fails" do
        expect(context).to be_failure
      end
    end

    context "when event id and authorization are valid" do
      let(:event_id) { "7rv3c04d721n2g271suh72gaoj" }
      let(:account) { FactoryBot.create(:account,
        refresh_token: 'correct_refresh_token',
        access_token: 'correct_access_token',
        expires_in: 3600,
        id_token: nil
        ) }

      it "succeeds" do
        expect(context).to be_success
      end
    end
  end
end
