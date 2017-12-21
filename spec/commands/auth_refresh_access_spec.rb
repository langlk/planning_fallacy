require "rails_helper"

describe AuthRefreshAccess do
  subject(:context) { described_class.call(account) }

  describe '.call' do
    context "when account is missing refresh_token" do
      let(:account) { FactoryBot.build(:account, refresh_token: nil) }

      it "fails" do
        expect(context).to be_failure
      end
    end
  end

  context "when account has incorrect refresh_token" do
    let(:account) { FactoryBot.build(:account, refresh_token: 'incorrect_token') }

    it "fails" do
      expect(context).to be_failure
    end
  end
end
