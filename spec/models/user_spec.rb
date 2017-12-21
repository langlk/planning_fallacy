require 'rails_helper'

describe User do
  it { should have_one :account }

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :name }
  it { should validate_uniqueness_of :email }

  describe '#remove_account' do
    it "destroys the account associated with a user when user is destroyed" do
      account = FactoryBot.create(:account)
      account.user.destroy
      expect(Account.all).to eq([])
    end
  end
end
