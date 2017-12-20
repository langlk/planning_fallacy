require 'rails_helper'

describe User do
  it { should have_one :account }

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :name }
  it { should validate_uniqueness_of :email }
end
