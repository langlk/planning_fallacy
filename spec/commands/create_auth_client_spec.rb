require "rails_helper"

describe CreateAuthClient do
  subject(:context) { described_class.call }

  describe '.call' do
    context 'when client creation is successful' do
      it "succeeds" do
        expect(context).to be_success
      end
    end
  end
end
