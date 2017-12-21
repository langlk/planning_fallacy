require "rails_helper"

describe UpdateAuthClient do
  subject(:context) { described_class.call }

  describe '.call' do
    context 'when client update is successful' do
      it "succeeds" do
        expect(context).to be_success
      end
    end
  end
end
