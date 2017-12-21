require 'rails_helper'

describe AuthFetchAccessToken, vcr: true do
  subject(:context) { described_class.call(code) }

  describe '.call' do
    context "when the auth code is incorrect" do
      let(:code) { 'incorrect_code' }

      it "fails" do
        expect(context).to be_failure
      end
    end

    context "when the auth code is missing" do
      let(:code) { nil }

      it "fails" do
        expect(context).to be_failure
      end
    end

    context "when the auth code is valid" do
      let(:code) { 'valid_access_code' }

      it "succeeds" do
        expect(context).to be_success
      end
    end
  end
end
