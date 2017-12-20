require "rails_helper"

describe Account do
  it { should belong_to :user }
  it { should have_many :checkins }

  it { should validate_presence_of :user }
  it { should validate_presence_of :access_token }
  it { should validate_presence_of :id_token }
  it { should validate_presence_of :refresh_token }
  it { should validate_presence_of :expires_in }
end
