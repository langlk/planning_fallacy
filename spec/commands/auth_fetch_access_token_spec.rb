require 'rails_helper'

describe AuthFetchAccessToken do
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
  end
end
